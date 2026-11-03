Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711789;
	b=E7SZBaRbdPBFAKXy/rFZ0ZTNgMThaqOTDEg4Oo0i0a2WITmmZKRdtIyVo5qv3Iy1/eTq
	 LQf3GYFVlVlD7wfyoXz/tuWkcapkYD8bw3qUr8I6yO0pN0IecT9yT+Y2CuaA237O7N/lN
	 zLhCOmXm/kJAzedkYjageci32Z1dJfHHqG7o0JucWJzqVDMzVA68nd/Bi6cejgkx988d4
	 dksXQaD4RsFeH7etOu3swOADdRhZrB01W5+RTMifin3exHxVWKzIYyueJcMwA+s9fLCT+
	 xj2xzppfw/8tvJ1PsGuGzXTjdDDEJfcg8YVzNZrgKgl6XcP/3Lup0HADOimLcPu0gwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711789;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GsPwaAJ+3z8o8BnV2wOdvjXMREOGtn5+ZtLYKDDMC3Q=;
	b=acYs1fWBBBWKu2OPSrI/hLgg4e5Dn/k1GP9shKBz4FjOoySfaoKQ/w0DMPqVSubzJpWX
	 jT4IToAOsNl3RTbgIZ9JlPPuc3HhX2HTb018NzrLzpYoWY6hdt+Flxw0fv/KRHY2vyVvi
	 4z0FGopZdfYddh13tomGIqdFmXVnH8VHCd66b7C6J9moGNBfwvoHrJUir7hHPxA/SkwnJ
	 R4EPWXYje6FJWCY3vGjRYQWidBVOVVnoFTibyK3TBpzGyv50oCjM9cp/tCjB/U8s1lnCc
	 sQHa2IVNr5oF3rqL758r2+uy+BL1DsGoXMvLEuVjLG3hnr0dU4EZwLPN+rytaz2jj+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aqHIYONc;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324F606A33E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4324F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aqHIYONc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GsPwaAJ+3z8o8BnV2wOdvjXMREOGtn5+ZtLYKDDMC3Q=; b=aqHIYONcxEavUlvcrAMQb5ZP5h
	HRENH0+0OD8PaMcB2d2Ee7fRAwhwsct4f4LBV+C18i8bvx1LwaQQ31IMZOn+klfze9XnzXtiilVSK
	OoFq0rLd/SZ+iVpOhEiIDy+50/O+exlE6euLx1trhlxhqRe3+sgYEGU16ojStobjjAiQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOENF-00E3XF-Kr; Tue, 03 Nov 2026 14:16:25 +0100
Date: Tue, 3 Nov 2026 14:16:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Zhineng Lim <limzhineng2@gmail.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: Netdev devlink A/B firmware bank selection feature
Message-ID: <c31e3852-11f1-4c5b-b110-226e6cc00305@lunn.ch>
References: <CAOr6SmEW8ZLjMzqCWdQL3W0DKwZCVaRL+DbhrSEZu7SeZRiVpg@mail.gmail.com>
 <34a6dde6-7a4e-4291-9f13-22d56793c866@lunn.ch>
 <CAOr6SmHqg5mH9W7LvruknDDohTAUwQTTxSsUN5mCCu9WV=5WJg@mail.gmail.com>
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
In-Reply-To: <CAOr6SmHqg5mH9W7LvruknDDohTAUwQTTxSsUN5mCCu9WV=5WJg@mail.gmail.com>

On Fri, Oct 30, 2026 at 02:18:32PM -0700, Zhineng Lim wrote:
> Hi Andrew,
> 
> devlink dev info+flash are implemented to handle 2 banks only. For
> instance 'devlink dev info' shows a "running" and "stored" field to
> represent the current FW that's running and the inactive FW on the
> other bank respectively. There are a few architectures out there with
> >2 banks but as far I can tell, devlink core only handles 2 bank
> cases.
> 
> Currently, devlink dev flash does not select the flash bank, it just
> passes the image to the driver's flash_update callback and the
> driver/firmware then determines where to write it to. I don't intend
> on modifying it.

Maybe you should? As a firmware developer, i would probably keep one
bank holding a known good image, and the second holding whatever i'm
developing. If my development image crashes and burns, i would swap to
the known good image. If the development image works sufficiently well
it can do a firmware upgrade, i would use it to overwrite itself with
the next iteration. That saves me a power cycle or whatever is needed
to swap to the known good image.

	Andrew
