Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55149364A;
	Wed,  2 Sep 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353726; cv=none; b=D8ZWcwmBSSfV+TYWcSck00f6hWwc25/31Uv8RRbBuNcYFoPxwDQwzraRUrpJf+17Fc8xfoN0NPncVhDLmElK77nxlqZg5sV7GRfTTC6YwOoKPB/hpZ3VMoN4KO9JGa6CuJqqIyFWmxJEEvn8Ev+iMSGqpPWbThn7Icv/MUUQaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353726; c=relaxed/simple;
	bh=sQKvBQ7EYxN8hdWOdVaSuYnQkrN2SWm3nvxM9b+stXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0MinK1sFMDea1v9ZYz4EDppl9sEzgV4I/WfneVmom3Ttxa1mt/oOWSg28eFAQfAH+H264h/kInGMLFpRNh4F5f0+OqCoEhgcV4+I8HV3KzFUGoTSDIfxpe6GeEMyfvmM/fSQ2IItR53iaShTzYODum1qhoC0x9bOevV7Afei5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VZXxAbsn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VZXxAbsn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rNf5DDLzp6ioVX2tzkJXExNnBQPMymyu1RA1hX5FgOc=; b=VZXxAbsnhveIlFc3ljB8w1lKF6
	fWcB3O3pp8HjJEBZU4a/gQuFMkJzAcD/nUEYf2xuoSIa7TwTIvXTSORtWWzp+/q/VjbvHJPfZawLC
	Qft6v9PL/dxjO0bfCkycXClVIWHN9zcbk+n436ljAjOXlY8J+subQ2OKqmrDN/7H5/3M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1kUq-002WMM-In; Wed, 02 Sep 2026 14:55:20 +0200
Date: Wed, 2 Sep 2026 14:55:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next 2/8] r8152: support RTL8159 for different
 packages
Message-ID: <0ce46ce7-2edf-4464-8029-cdc6e9b9f854@lunn.ch>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
 <20260902090632.41844-3-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902090632.41844-3-nic_swsd@realtek.com>

On Wed, Sep 02, 2026 at 05:06:26PM +0800, Chih Kai Hsu wrote:
> RTL8159 has two different packages, QFN68 and QFN100. Therefore, split
> RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100.

Why does the package matter. The commit message is about answering the
question "Why?".

    Andrew

---
pw-bot: cr
