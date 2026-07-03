Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA0236453;
	Fri,  3 Jul 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092697; cv=none; b=mQvUQHoXpbgxUYqAt0Cmt9xBf2Wd5IhrUTr9GaPOsKhLuCeBC5jl6Xh90wvYSkxAsBhgXFRVXY6Yx7htUWm/WW0Z+PcKe5IWRY1BzAaOj14OWaWzP46Y8q8qvaIhfjmLMikH/VpxnGsz7mLCIoItNF33dMBmusvN15IHrTaIb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092697; c=relaxed/simple;
	bh=QC/6uZNy8zYI82J+rf1kQB4r799DDxx/ZhOG+OW1DXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOUY7VFJWGUKIQJlr/G8nFql1CnunRNm8PT0RV+9gHOoS3+KAb3NfgXvqbAYSltd2qvgOOuXLsL76FrYQTxYBE24Vo8P3VjRlljpKKNEvEb8wpEt88v70eoyHMzIQYr+TLekvZtULPympIJhmG9axJnWOtacS6+0NtvPxthn3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LVx809SB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LVx809SB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CgrTUblCPjxXhECL6iFBBKmla6JWWmq3mWzt7wMOPzY=; b=LVx809SBVvQuzEZGQcF9ebSlCl
	x8ZTSk7xYF+Sksq4MZhkYjH4b5I5pcyLFXFIL/ZV0ORj1TVupxoZ7vJSQqtvp0dfpUuxCo+PIcIKv
	kPfQ9NAQuoKEdP7LBN7wHBlgvhLs51ZVNm22JcKksk26tEv0Sur5gCc+q1w7/5Fh1Pgo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wffrQ-00AZDe-88; Fri, 03 Jul 2026 17:31:24 +0200
Date: Fri, 3 Jul 2026 17:31:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: write the ATU FID
 register on 88E6141/88E6341
Message-ID: <eadfade3-c46d-42fd-8301-3b2acebd7bcb@lunn.ch>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
 <20260703-mv88e6x41-fixes-v1-1-fbd3a1bf8965@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-mv88e6x41-fixes-v1-1-fbd3a1bf8965@padl.com>

On Fri, Jul 03, 2026 at 04:42:55PM +1000, Luke Howard wrote:
> The existing code assumed the 88E6141/88E6341 did not have a dedicated
> ATU FID register because of its database count (256), instead taking
> the legacy path which resulted in the FID register never being set.
> 
> This resulted in every FDB entry being loaded into FID 0, breaking
> VLAN aware bridging.
> 
> Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")

Please submit fixes to the net tree.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> @@ -131,6 +131,7 @@ struct mv88e6xxx_info {
>  	u16 prod_num;
>  	const char *name;
>  	unsigned int num_databases;
> +	bool atu_fid_reg;
>  	unsigned int num_macs;
>  	unsigned int num_ports;
>  	unsigned int num_internal_phys;

Please think about padding. The current structure layout is not great,
invalid_port_mask should be somewhere else, but please don't make it
worse. Also, this structure has some reasonable comments. You have the
chance to comment that the number of FIBs does not imply if there is a
dedicated register, there are examples with 255 and a dedicated
register.

> diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> index c47f068f56b32..aa5adc78607ca 100644
> --- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
> +++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> @@ -135,7 +135,7 @@ static int mv88e6xxx_g1_atu_op(struct mv88e6xxx_chip *chip, u16 fid, u16 op)
>  	int err;
>  
>  	/* FID bits are dispatched all around gradually as more are supported */
> -	if (mv88e6xxx_num_databases(chip) > 256) {
> +	if (mv88e6xxx_num_databases(chip) > 256 || chip->info->atu_fid_reg) {

So currently, > 256 implies a dedicated register.  But do we need both
> 255 and chip->info->atu_fid_reg? I would probably set atu_fid_reg
true for all devices which have a dedicated register.

    Andrew

---
pw-bot: cr
