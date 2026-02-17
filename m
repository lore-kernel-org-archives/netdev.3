Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5E21423C;
	Tue, 17 Feb 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345147; cv=none; b=d+j/hEqXd/hPWeV29+4fMD8ZD54NPcIZ1BT50WKJCopx7/bnXLvELdYVKqPRcpOHdc3bH9cRw4dt+NU5jBtd2KXZfhYYCiJbCQoOo0dZQ0ZScl0/Z2L6uLIXVOqaS9nFhMH8OZ3wAoY1AXpOESyGRoPs2mcSJALjdglfDM3FIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345147; c=relaxed/simple;
	bh=4iIanjQFicUdbZHRHIdOpjPkHk6tWxPkLtOn8Ct+Khc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpvTbVlHX/CH26ILzz6QNMURtOHb3FFeMGBdmUUWC+dsFpw6YJG/gWdVSyvkdKTeXy/KIiJtWrZ16LRGNyETHR2qpLIj2qZXk3P+y0uFHtzPzQ6TViptHyM/91oUE2u4CKBAD6BqMsyFmmvqDDMjyeHv/fwMrfYNkRhKUo8he10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NhRRT++r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NhRRT++r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PlPHgvEewjWWxsmr8WaBg4rdwZetFGFPF5F6xSfv7i8=; b=NhRRT++r/7X/+UlWgHPDYMHZ7N
	FLJe6v/yJRn6GspJhBwBOM1653TP2hor/8qWiisOCBtzCUc0H+Pr930vMbJr+r5T9xtL2h6yUKV1D
	L7qaTdodiYwItMIZ++LuLGZn2TRupdzZS5aaLk+wPwmBgVgcYNdeT2G84mfagk+9QiEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsNmp-007fA0-JU; Tue, 17 Feb 2026 17:18:55 +0100
Date: Tue, 17 Feb 2026 17:18:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2] net: dsa: mv88e6xxx: Add partial support
 for TCAM entries
Message-ID: <cb537f04-8146-4f69-b44a-ec14617eabb9@lunn.ch>
References: <20260217-net-next-mv88e6xxx-tcam-v2-1-d84cf420da46@luminex.be>
 <ab9b4278-2c0a-4ed5-9da0-2a7a3f928ed7@lunn.ch>
 <PR3P194MB1505A036B48F93F124CE241AEA6DA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3P194MB1505A036B48F93F124CE241AEA6DA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>

On Tue, Feb 17, 2026 at 03:55:02PM +0000, Cedric Jehasse wrote:
> Hi,
> 
> >> +#define mv88e6xxx_tcam_match_set(key, _offset, data, mask) \
> >> +     do { \
> >> +             typeof(_offset) (offset) = (_offset); \
> >> +             BUILD_BUG_ON((offset) + sizeof((data)) > TCAM_MATCH_SIZE); \
> >> +             __mv88e6xxx_tcam_match_set(key, offset, sizeof(data), \
> >> +                                        (u8 *)&(data), (u8 *)&(mask)); \
> >> +     } while (0)
> >> +
> >> +static inline void __mv88e6xxx_tcam_match_set(struct mv88e6xxx_tcam_key *key, unsigned int offset,
> >> +                                           size_t size, u8 *data, u8 *mask)
> >> +{
> >> +     memcpy(&key->frame_data[offset], data, size);
> >> +     memcpy(&key->frame_mask[offset], mask, size);
> >> +}
> >
> >I want to look at these two in more detail, i don't like macros like
> >this, nor inline functions in header files. But maybe they are needed.
> 
> The macro is used as a compile time buffer overflow protection.

Functions are better, so that you get the compiler doing type
checking. But the typeof(_offset) suggests you might be passing
different types? But offset should just be an unsigned int? As i said,
i want to look in more detail.

And i don't see why __mv88e6xxx_tcam_match_set() cannot be a normal
function, and let the compile decide if it should be inlined. There is
nothing performance sensitive here, this is not the hot path.

> >> +             mv88e6xxx_tcam_match_set(key, 16, match.key->n_proto, match.mask->n_proto);
> >> +             mv88e6xxx_tcam_match_set(key, 27, match.key->ip_proto, match.mask->ip_proto);
> >
> >What are these magic numbers?
> 
> The offset in the frame used for matching. The Ethertype is at offset 16, the ip protocol at offset 27.

These are the sort of numbers which probably appear other places, and
so might have #defines for them. Otherwise, please do add local
#defines.

	Andrew
