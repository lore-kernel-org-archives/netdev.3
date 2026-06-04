Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B42BE7CD;
	Thu,  4 Jun 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584330; cv=none; b=JxuV0TEqj0Fg/DLy5x66JnAf+MXzuXtsIItk4Hv58I3oOTCOI8L4cE6Jo+BmXbLX1kR6CCvAWRE31f8J+WfSIpFHLlr+ob0wq4L3EcYSjE6znQvysWAhRNmfXFSM8FnEUclWG3gFgouOEt5okG1zHJ3cxpyAze5Tifest9deE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584330; c=relaxed/simple;
	bh=N6k9Hbk3fVXltHc2Tt8yt9LYYq+UfIGUDIHxUwll2rg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDUTdJ1lahbKtxXyc7puU78RPyvzHVpslTRE2BD4NiFVAkwd2peawA6ejNfqhSKd2ZnzxFEa5YZpbtNj5YGNcNe+rdZ4MCVOH3E1EtXZm+VaYmzes08nozwGhrYpLNhvcBxtwpveWRz6l5nU+Pk471RDEI+RIS7CuxrFH8i3tM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxfAs0jb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxfAs0jb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0141F00893;
	Thu,  4 Jun 2026 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584328;
	bh=N6k9Hbk3fVXltHc2Tt8yt9LYYq+UfIGUDIHxUwll2rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IxfAs0jbHtodi2eo53WrrS8ASUuYHDLxsOWa8KjY+28/sEttAEHX79jTOU0Q0TraL
	 0qxdyOo/HI9mucQo0guJ1wJbzJnz5P34M7PRAbO9m1sOaxqfBcpZ0rLizOY7W3NlfM
	 b6nA2bey9sF9mezhlPCmVO2VoNd5yLHcMyd45PA64ED3UrIHrw9ZrkGW8Btk5S5fyQ
	 POEPZd+qo2PsQKatKzzSh3L+TkoZqbbHjXQdJoCXXRqy/OLgiZeRzTQ/gZ5VK/uUee
	 4VjyfM8LtZjgUeES3ocqvP5k3DF3ovwmUr/lohKTRdLL6bSBfflqmKAqohPmcJ+4Hr
	 NmDqy1zJ1Z1Vg==
Date: Thu, 4 Jun 2026 07:45:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
 <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 1/8] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <20260604074527.702f7a3c@kernel.org>
In-Reply-To: <aiDgvzA2pe8FXJOL@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
	<20260602060359.1894952-2-rkannoth@marvell.com>
	<aiDgvzA2pe8FXJOL@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 07:49:43 +0530 Ratheesh Kannoth wrote:
> There is only one AF device per system. So this case wont happen.

Can you explain why? I thought this was a PCIe card, not an SoC driver.
