Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5635E1AC;
	Wed,  1 Jul 2026 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917275; cv=none; b=Vpk5FmMNP+lnEFPcNEMUSCYM/fGmcKpsIjRcEXuIS0Lu0kRg7m5RPTnJeeIqE2M7yPEJul5F7E4+VZ+we9RxzFV9jACO6LgO7yMYUnhOxae4W1tDLz0HsTIIYibQZ7beKFxSvB4/0xXUl/bapXDH5xL2tria8sLnsOUb0O+DsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917275; c=relaxed/simple;
	bh=+YDaJDyGb8xZrVbN2iD3LxVfqXcvFqd06rikh36uTjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6fEc9eqV24lwbVSOww7AD92QeIeqhP+ZF18ELYCaZN+1Hnyr/DuCXHrNdr7kxSo2tyiM+2/xkBtTjlhwf0PsDtTjaRgrlkL04CG3ke81pKqfvMFtqCwjNSAy1MmifXWea5Q1fk39zp+AJqW+v+BuFyUlYaVszd1HSfiPyPfxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=394jW/JJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="394jW/JJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lzO23dF/yCOKFNCgqBrdjraf+bzC5qpqDx3mwunUZ+c=; b=394jW/JJG8LQx5mZyrPZnVIoQO
	YVSBTEzojcZ7/EQYehXTlnFV8lwlWvt8DFkdO9DxioYE7sMfYU305bFruFc8T8qT6OMmtRXkPkEjA
	prKQftqT4uuD68vZK0ap0jvrFBlTW/VeOkrPElcdQqIU7wFkPUCgmMLwfTMhm1cS1nHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wewE5-00ABUO-Eg; Wed, 01 Jul 2026 16:47:45 +0200
Date: Wed, 1 Jul 2026 16:47:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v2 1/1] net: rnpgbe: fix mailbox endianness and
 remove pointer casts
Message-ID: <08c1c12e-5990-46bf-998a-525c36c69da6@lunn.ch>
References: <20260701032208.1843156-1-dong100@mucse.com>
 <20260701032208.1843156-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701032208.1843156-2-dong100@mucse.com>

On Wed, Jul 01, 2026 at 11:22:08AM +0800, Dong Yibo wrote:
> The rnpgbe mailbox exchanges data through 32-bit MMIO registers in
> little-endian wire format. The original code had two problems:
> 
>   1. FW structs (with __le16/__le32 fields) were cast to (u32 *)
>      before reaching the mailbox transport, hiding the endian
>      annotations from sparse.
> 
>   2. No cpu_to_le32()/le32_to_cpu() conversion was done between
>      CPU-endian MMIO values and the little-endian payload, causing
>      data corruption on big-endian systems.
> 
> Fix by adding the missing byte-order conversions in the transport
> layer and introducing union wrappers (mbx_fw_cmd_req_u,
> mbx_fw_cmd_reply_u) that overlay each FW struct with a __le32
> dwords[] array. Callers fill named fields using cpu_to_le16/32(),
> then pass dwords[] to the transport, which now takes explicit
> __le32 * instead of u32 *. This eliminates all pointer casts on
> the mailbox data path and lets sparse verify the conversions.
> 
> Fixes: 4543534c3ef5 ("net: rnpgbe: Add basic mbx ops support")
> Signed-off-by: Dong Yibo <dong100@mucse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
