Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF333F583
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645856; cv=none; b=SIDOCUQ3XjTLF0jPwZUtyM7hD7BtOgzwrEXbgAGlpuLES9F9ieNDnObSmxEt0A6K7EuYHi5Qbw9IUNrjiMPN/spUhRBVqExtae0dLSQt2pfhC0rDj0Rm16KELqbUqti8ioYJmPvKn1aDxo321ihV3pLQ75JUkb+lDTY3LKu0xQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645856; c=relaxed/simple;
	bh=2oisk94rQ7e08xCiZpDF0c8wsp3g2v+VwV9wlN7xkMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH75qekH7V//i4dolePe911P8nrITRj2k84jZ4Eq4Sf+67tj972Nn8h3wstJrN24ElrLHQx3cfMpjuQmv1ciNAdgtdAquO8w+iYcm87Sln32ieAtw62It5lioZBD//tqZ293bsVd91N48YwcibqTFq0aWxlR93kGLvbICgWgHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPjh0GCs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPjh0GCs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490d6730461so5328465e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781645853; x=1782250653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MT5iqv5WuDY1HU+Yy+3XhVU4jJr3OzxcWtB8H4DLMc=;
        b=jPjh0GCsD0rKAFyGOKY4lho9XaQC6MMGvNmcjd4FYZXFcXJVBcttEG13S/VGlINez+
         b9uIpNG0mteY9nnkLncTMZ5ITocAQR3+oR+O0Y9Ra8tI6NjnLWeXmuiX0lgqOGygrqrX
         4B+U3eKOnNdJwpVGAc65Su7uz8tr7tod576ewBZwp+vDVLzq3FBpFYFl1kCxpVQSKWiw
         FFQgDSYDXHC3X7djF8R+saOZu73y2AFiL2bpSO4FjB4IOnsrL/ZnG14E0mY0v4xHJG+G
         +3EdP20eJU+ZMsmz7WQ7FdiLCuztLfeC3hxUCFO//eHTh7bOBTuV7Hl+R1aosnREGD4H
         AF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781645853; x=1782250653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MT5iqv5WuDY1HU+Yy+3XhVU4jJr3OzxcWtB8H4DLMc=;
        b=Ry4BR6xPexYIgce0dAFb9gGC6R/8kcxkK5ENshAhHCZjDRlTRmPyw0zPKrx2MI/EhS
         T7W+sHztiU6QSgfIYVI7uVhBGafIrSA2ZPyNF3SBsmGDFXBNTNB6jPYKnWpsbAOjtsFN
         DHfe1G8f+PO46ry1x7L2+WefAISIVBPgpZfcG/vTbFmniJLF4RrPvXYvG56FTRXmRmIp
         4zf6ZvyxJOh9QT0g8RPaYV5Fu+KZpHf2MIngSjWX6xuXO1gkyGkPf03FJVVqwVW/0oNA
         sgZqOO7P/2uTR1PPBqo6U7sSIFDoBUTwfITOY0RzF8Rf5yhIivejAf6hZLA2uOr/HRe8
         SkrA==
X-Forwarded-Encrypted: i=1; AFNElJ/5g25Q2aoEWAvlsSZR9/vXSkXL9t+nNFymowBXERi5j2Kp3wPtkOlAsA5HpbjeNAk+YOaRiN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypUvKXL8IY44Q83NPzx7fJNljEN/csonQPiooR1A85mbldtdW1
	GIWmv5xRboMql7rc2YLGpnYk5kJW/SMLQvLmTbSDrW61qx4zqLIdvWgA
X-Gm-Gg: Acq92OFH1FSqa9j6kaFdZeEBTIi27SB9hdQU9SSNEL1TkA0p3YCxV4/gzrV8H9q4uhb
	jpHwNiz4hvnV+Zva1/3fuE0Kgna7my3DDanxvWHqrZ2LzJ4+BdmKSbr9H+LL51C/fQCsXvVNFZZ
	7bBzJSu7EWf9wLIJFthB8qdPFLhxPoMhcRpl72GmOTIFzbnMb4u9jujqp7X6uaVb/rIL6Y7f/J3
	1qMW16dB3zhoi+RROmsZ6SVcu9I9rcXUxI6ECla407YJ57PxFY6rFuuoif5W5kAHOctIyJbERPC
	HYeBlFAxSxxUjKhh6VZN9ub3O1HKHzIpp8/reAl0FfOR/xI+zQwfutGlpMDRCXvFwn+WW5KpqWa
	ufYBxbcpmj1XV3JefM6cuNpRX4vCvpXQ9dLzlZLdelFp063OANXahuquptIJ73J9KD5GjcR1/Ez
	vB9j75IHwA9nT1Pv8=
X-Received: by 2002:a05:600c:3f14:b0:492:2e5d:9706 with SMTP id 5b1f17b1804b1-4923412d770mr2659195e9.4.1781645852664;
        Tue, 16 Jun 2026 14:37:32 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:b560:2eb9:3ced:38e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4f8d7sm96675855e9.5.2026.06.16.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:37:31 -0700 (PDT)
Date: Wed, 17 Jun 2026 00:37:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	George McCollister <george.mccollister@gmail.com>,
	David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v2] net: dsa: Fix skb ownership in taggers
Message-ID: <20260616213728.xhja2net2vbjmgzb@skbuf>
References: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
 <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
 <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>

On Tue, Jun 16, 2026 at 11:36:22AM +0200, Linus Walleij wrote:
> The tag_8021q.c tagger calls vlan_insert_tag() in dsa_8021q_xmit().
> vlan_insert_tag() will consume the skb with kfree_skb() on failure
> and return NULL.
> 
> When NULL is returned as error code to ->xmit() in dsa_user_xmit()
> it will free the same skb again leading to a double-free.
> 
> The idea of dsa_user_xmit() and dsa_switch_rcv() dropping the skb
> they held before the call to ->xmit() and ->rcv() is conceptually
> wrong: the pattern elsewhere in the networking code is that consumers
> drop their skb:s on failure.
> 
> Modify the ->xmit() and ->rcv() call sites to not drop the SKB if
> the taggers return NULL from any of these calls. Move those drops into
> the taggers so every callback error path that retains ownership consumes
> the skb before returning NULL.
> 
> Keep the existing helper ownership rules: VLAN insertion helpers already
> free on failure (this is the case in tag_8021q.c), while deferred
> transmit paths either transfer the skb reference to worker context or
> hold a worker reference with skb_get() and drop the caller's reference.
> 
> For SJA1105 meta RX, transfer the buffered stampable skb under the meta
> lock and return NULL while the skb is waiting for its meta frame: the
> skb is not dropped in this case.
> 
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260610153952.1685895-1-kuba@kernel.org/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Assisted-by: Codex:gpt-5-5
> Acked-by: David Yang <mmyangfl@gmail.com> # yt921x
> Acked-by: Kurt Kanzenbach <kurt@linutronix.de> # hellcreek
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Changes in v2:
> - In some instances __skb_pad() and __skb_put_padto() followed by a
>   kfree_skb() could be simplified to just call skb_pad() and
>   skb_put_padto() which will free the skb on failure.
> - Use a label and goto for the kfree_skb(); return NULL; in
>   the netc_rcv() callback in tag_netc.c as requested.
> - Collect ACKs.
> - Retag for net-next.
> - Link to v1: https://patch.msgid.link/20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org
> ---

From my perspective, the tradeoff between pros and cons is not so well
explained. Consider the following not mentioned in the commit message:

- Changing the kfree_skb() convention, without any mechanical obstacle
  preventing the backporting of patches that are written assuming one
  convention down to trees expecting the other (obstacle like a failure
  to compile, for example, which would warn people of their otherwise
  silent incompatibility), is an avoidable experience (at best) from a
  maintainance perspective.

- Has anyone proven that a real problem exists? Because dsa_user_xmit()
  -> skb_ensure_writable_head_tail() has run successfully at this stage,
  so we know that dev->needed_headroom bytes are available for writing.
  Because DSA uses VLAN as a tag, dsa_user_setup_tagger() will increase
  dev->needed_headroom by VLAN_HLEN for the tag_8021q protocols, so
  vlan_insert_tag() should not fail. I've looked at this function at it
  seems not to be coded up to fail for any other reason.

Otherwise, sure, it seems cleaner this way, but the way I see it, it
risks introducing more issues than it fixes. If maintainers feel
different about this please go ahead, but given the fact that I don't
really have a lot of time to do proper review during this period, I'm
more on the pragmatic side on this one.
