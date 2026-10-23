Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764135;
	b=LO7BjRfRMfu4czJ9A9UmNh3v1CaIK/42JdvZehjmoGGvvb6n3QtMVNTmRg1v0NcDWemJ
	 Y4Sredl+XOqwEOEGK40QMEQzQoi9Z/XsVXMcq6btSsLgFjGAGj8dD4WY3fOPitNZUGomM
	 rhBHib4Fuz38bUAt9yHyklNcB1bYN3W8W6SJN8IQykpvLdoSKvlZEjpatKH/SZtD/j0gT
	 8BeX5iwFxgIJW5+JNTS8Wc//paYP90WA0XmOuvbu8qj1Ji9eZ9cHaTZN26uVkup2+t9Uw
	 Hul88+s6mkiPRnesE1jt3G+bEAFvhb6CiMs3vKvcToL7tlhZH6IHEjcU5HxNWqP2ODQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764135;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nsNWSUHVr8eAmb7Rlygj3NMQOCr3IMuX87wO1+nC8Qc=;
	b=2FUQOyyp1DsTqwK3qkfu1yEXV8DuLVcNuTQDZQE9gZBycrpTVwL7xFVb4Sc6xYfcyGdB
	 E6JLJvBfyVEMF1v2hF6mk5JfXipr2lxErlBIkLlovYUH/0Reupt8flYyWrOz2tWdkfnju
	 GmE0TFzuI1csZlYXZuCiP8NP6R+/T6hgQBocz29RhrSTX8hQ7HdzaSZz/kl8iWZ7VpRMe
	 g4M0WY/xlSBQxcJtfBxkfDTkMWVzwU9rUKH/wcX0x4FAMWA/mtFkVZ7l3TLQjiYuX/1YO
	 iyA+EmBumxWNS3UjxE/mDXqnIaBKuNCX9kB1OKy6dnInC73f7rzhEBPTxKm7hG46rag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="Buc/Rfi3";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468DA606A31B;
	Fri, 23 Oct 2026 14:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468DA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Buc/Rfi3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nsNWSUHVr8eAmb7Rlygj3NMQOCr3IMuX87wO1+nC8Qc=; b=Buc/Rfi3awGBHhqMmwP2LdTTNt
	MN+YXqBcLMlwba9V88w2HsT6iU8JiEiVLijQbrDB5A8PEiKZ+q8rS28gLObyG9Aht9MzBIEaiAl2C
	6gxVQ32X0rBJ4YA1m2zgaEoC8GFHq05g/hkl133fqObyPuipXwl3Cba1M178M1V3kVFo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xKFqU-00CQEV-ED; Fri, 23 Oct 2026 16:02:10 +0200
Date: Fri, 23 Oct 2026 16:02:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Nimal Prabudoss [C]" <nprabudoss@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com, mschmidt@redhat.com, manishc@marvell.com,
	palok@marvell.com, spadol@marvell.com, jtaubepe@redhat.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for QLogic ETHERNET
 drivers
Message-ID: <d1dcada0-9949-404e-b08a-7ed91d9d4e96@lunn.ch>
References: <20261023125409.1989-1-nprabudoss@marvell.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023125409.1989-1-nprabudoss@marvell.com>

On Fri, Oct 23, 2026 at 06:24:08PM +0530, Nimal Prabudoss [C] wrote:
> From: Nimal Prabudoss <nprabudoss@marvell.com>
> 
> Update maintainer list for BROADCOM BNX2 GIGABIT ETHERNET DRIVER
> and QLOGIC QL4xxx ETHERNET DRIVER to reflect current team structure.

Why Cc: the scsi list? Who do you expect to actually merge this?

>  BROADCOM BNX2 GIGABIT ETHERNET DRIVER
> -M:	Rasesh Mody <rmody@marvell.com>
> +M:	Nimal Prabudoss <nprabudoss@marvell.com>
> +M:	Sharad Padol <spadol@marvell.com>

~/linux/drivers/net/ethernet/broadcom$ git log --pretty=format:"%an" bnx2* | grep "Nimal"
~/linux/drivers/net/ethernet/broadcom$ git log --pretty=format:"%an" bnx2* | grep "Sharad"
~/linux/drivers/net/ethernet/broadcom$ git log --pretty=format:"%an" bnx2* | grep "Rasesh"
Rasesh Mody
Rasesh Mody
Rasesh Mody

We generally want Maintainers who have shown they can do the work,
posted patches, answered questions, know Mainline processes, and don't
spam other lists etc.

Maybe it would be better to leave it without Maintainers, at least
until you have reach the level Rasesh Mody achieved.

      Andrew
