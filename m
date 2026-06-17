Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAED39022E;
	Wed, 17 Jun 2026 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687257; cv=none; b=Rp2YHMyPlVeKOgXRnqGEIw1OPgKj8ftzsRzKSIXc7h95XEDMgEoPge4eeFwdYa8yk3yBlcDRfbPJNPfrsceLnlnx13R9CIG78dGsefcrqewe6uLz/A3ZpADsJ8UtsxL1fLI31nCSqwbl5HRAGvgiJrDdlT846UW2BmGl/onUCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687257; c=relaxed/simple;
	bh=zQDBg7W0tjJGt6fZCeNBPHVz0JlrFM2CG+k3SzBRxOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWW6pOl6NfJ5OtNBBRyTtYunnbtqikPTur6eakI8bQueyAFPhd3Exv8vYx7jah5NjYk+VkvQbsUQQUrg3IKXhVjzHmLTr4oXCqpSuhmQ727ijm1qwU+1mm263658t9/fwRoMC7dHi61OpTAG8zdCoc2X4lrlmGq0TYt+qH4oRMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=05W0qCRV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="05W0qCRV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9mQCjsi7dlJQ+lSZ9sXoEOXpUYxJ+F2D5zZ7rEHJnEI=; b=05W0qCRVqSkMVkmOh7ERVV0dIn
	FoYF8EbXzhP7yJ5mvGgDdaX0508HQQhmccEwTwBmDTLfoceJUR6YxRklyEqBDj+Wr5Xqu46ANt6qx
	kKpJUDi7GpcHmhCd1F0zqx8HLlwFygY/B5DpBVrSGLlmZBF+MUwwX2lRGM/oF5Ou5W5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZmF1-0089Yw-0F; Wed, 17 Jun 2026 11:07:23 +0200
Date: Wed, 17 Jun 2026 11:07:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	de.ge@motor-comm.com
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
Message-ID: <a689a734-bfd2-4e8f-85dd-9ae210b3161a@lunn.ch>
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
 <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com>

> >> +#define CMM_PARAM_CHK(expr, err_code)    \
> >> +       do {                             \
> >> +               if ((u32)(expr)) {       \
> >> +                       return err_code; \
> >> +               }                        \
> >> +       } while (0)
> >> +
> >> +#define CMM_ERR_CHK(op, ret)           \
> >> +       do {                           \
> >> +               ret = (op);            \
> >> +               if (ret != CMM_ERR_OK) \
> >> +                       return ret;    \
> >> +       } while (0)
> > 
> > Do not use macros like this.
> 
> Ans: Acknowledged, i will consider how to optimize them in the future.

It is not about optimization. Hiding a return statement in a macro is
very bad style. It will lead to locking bugs, and resource leaks,
because nobody knows the return is there.

> >> +/*
> >> + * Macro Definition
> >> + */
> >> +#ifndef NULL
> >> +#define NULL 0
> >> +#endif
> >> +
> >> +#ifndef FALSE
> >> +#define FALSE 0
> >> +#endif
> >> +
> >> +#ifndef TRUE
> >> +#define TRUE 1
> >> +#endif
> > 
> > Nonsense.
> 
> Ans: Acknowledge, will be fixed later.

No. They will be fixed now.

> >> +       /* Print chipid here since we are interested in lower 16 bits */
> >> +       dev_info(dev,
> >> +                "Motorcomm %s ethernet switch.\n",
> >> +                info->name);
> > 
> > Stop copy-n-paste.
> 
> Ans: Sry for this, i will recheck the code to make sure each line of comments and code
> meaningful again.

Also, consider the comments. Do the comments add anything useful which
is not already obvious from the code. Comments should be about "Why?".

> >> --- a/include/uapi/linux/if_ether.h
> >> +++ b/include/uapi/linux/if_ether.h
> >> @@ -118,7 +118,7 @@
> >>  #define ETH_P_QINQ1    0x9100          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>  #define ETH_P_QINQ2    0x9200          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>  #define ETH_P_QINQ3    0x9300          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
> >> -#define ETH_P_YT921X   0x9988          /* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> >> +#define ETH_P_YT92XX   0x9988          /* Motorcomm YT92xx DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>  #define ETH_P_EDSA     0xDADA          /* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>  #define ETH_P_DSA_8021Q        0xDADB          /* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>  #define ETH_P_DSA_A5PSW        0xE001          /* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
> > 
> > UAPI stands for User-space API. Do not change it unless there is a
> > very very good reason.
> > 
> 
> Ans: The default tpid both yt921x and yt922x is 0x9988. I have modified this to 
> allow for simultaneous use in both yt922x and yt921x scenarios.

As pointed out, this is UAPI. Any changes to this file need a good
explanation how it does not change the user API. Do this break
backwards compatibility with user space applications? Maybe tcpdump or
wireshark has a dissector which expects ETH_P_YT921X and you have just
broken it?

> >> +#define YT922X_TAG_FORMAT2_NAME "yt922x-8b"
> >> +#define YT922X_FORMAT2_TAG_LEN                  8
> >> +#define YT922X_PKT_TYPE          GENMASK(15, 14)
> >> +#define YT922X_8B_CPUTAG_PKT_FROM_CPU      0x1
> >> +#define YT922X_8B_CPUTAG_SRC_PORT          GENMASK(6, 2)
> >> +#define YT922X_8B_CPUTAG_DST_PORTMASK      GENMASK(8, 0)
> >> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0      BIT(15)
> >> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0_EN      0x1
> >> +#define YT922X_8B_CPUTAG_FORCE_DST         BIT(9)
> >> +#define YT922X_8B_CPUTAG_FORCE_DST_EN      0x1
> > 
> > If yt922x tag format shares no common with yt921x, make a new tag driver.
> 
> Ans: thank you for your suggestion, we will consider whether to create a new driver in the new file.

When you look at other tag drivers, you will also notice some drivers
implement two taggers in one file. So consider this if there is any
shared code.

> >> +static struct dsa_tag_driver *dsa_tag_driver_array[] = {
> >> +       &DSA_TAG_DRIVER_NAME(yt921x_netdev_ops),
> >> +       &DSA_TAG_DRIVER_NAME(yt922x_4b_netdev_ops),
> >> +       &DSA_TAG_DRIVER_NAME(yt922x_8b_netdev_ops),
> >> +};
> > 
> > If both are supported by the chip and 4b does nothing more than 8b
> > does, do not bother with it.
> 
> Ans: 4b and 8b dsa tag may have different application scenarios. from my opinion,
>      1. 4b dsa tag can save 4 bytes of payload
>      2. 8b dsa tag carry more package info.

How do you plan to swap between the different formats?

The user perspective is that the machine has a collection of interface
which are used just as normal, using Linux tools likes like
iproute2. If the user enables a feature which requires the 8b tag
format, will you change the format from the DSA driver? And swap back
to the 4 byte format when the feature is no longer needed?

	Andrew
