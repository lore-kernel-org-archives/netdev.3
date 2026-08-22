Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3B246781
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432155; cv=none; b=lcXCGtqx2DcEr5Zxqb/GMh8yj2gPy1quY+SlKKUHNlt167PoYkt/yG11fXEa6cDzMSax0sNUJXEctSX9joJs7dpoKsChl7pGOilifuZyS9uOiFANtD3P/EPruJuFlKvHFvDsKD5g1CW84p2AS068xhciQ6b9EjNQBqFn3voHSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432155; c=relaxed/simple;
	bh=d7Wm2ZfHIDm7ouPgbVQMroG5P5fb1VVVnpsqxt6VAFM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kVUzZQyd+HNHDbI5H3XSxJKdh5sNXlFVVkYt/YE5egkhmKp8x3/nmfDcKzH/GL2eESBHfm5AnVurq60MRY0aZbyHqWD7ljmFLGQKrR+k7zisOCxxdMRP/hHr3hQD6cnyospPWfGisf15PBE+wKTeZbPC/TdCk4BJdtTUvRnCDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/zinSad; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/zinSad"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7ff05e5d009so32305947b3.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787432153; x=1788036953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S5V/q31bjTfUMDrf97iKysR6FrEMNDpiONny2xwLCfs=;
        b=M/zinSadAfyr3ZE6JX2LkKzaqKA9MUTXOZqwfjdfX0YdBfHisMNlFmAKqqmCaNf+fo
         Jtfkqy+qEAhh5PmGON1wOH0G3dYvX6/uRx9gxxBkQ1NnDNJahtISGKSr4d9rBLgQTeKj
         dYjgk7UIgJi8FXiwfvk4llB54vMPdtK+W5LM+i1JCvrABKoVj/GQvJ7pRVODorgYKxdK
         qY6XMCMCG3p6MqgRyIFkjhbp7/NSFkQGfn2q1woZ9NDDijhfMNWNYiZtMP0VS2drbIua
         C4Xrh3BKqn1uTkp3dDebeN8ydWnsbCz0OetzchicGZ15sOL7h9iQ7is1Y5ce4vERKGKN
         szYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787432153; x=1788036953;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5V/q31bjTfUMDrf97iKysR6FrEMNDpiONny2xwLCfs=;
        b=ZSJ8VNMdXmODOM5tqeJE2q6pPvAcbrUgQXze/hBrh6ObtczUOO6O2JY2PLkGsLEXoe
         u1RtLqVcWFN8mPKGMSSFYYJChA/AnNDnk4mdG5p9UOQ6m0GlEiSCGm4bNgqF2ol5NEZq
         TvFC5WAAuSQYYQVRSTlayYfeugj4w1pyPwYwzKsUHHlpEr/t8Z2CJH3avZyCQEU65Z74
         rLP/pe3KhiJRX40XrYy26ZBTlu2SvM+kU6Yac7+uEQXmqlJYr6Xh2TyFsoJnk46ZFb6I
         5XLObzjd+ER6vmGVAZqydGhln2fHCtdkvra5KNv2tS9uus61kCACQL9qQT2UsZ3LK96F
         vBJA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2LjVW0piE4x/EH04fwbfy9i9hI/Llf1RY8cWtmYAXJqY7HSeb/LptFD03HhusPw5sOoGESLA=@vger.kernel.org
X-Gm-Message-State: AFuF++l/cE7dciEcK1urZ4sg/oFF1Sxoivk54j17jdrgOi9sYRu5/v/3
	KkX2rMLQYCUhofEcUZ2CoI/l0ig1aytRnhuiQ8T5Xi0TIIga7+SbhzaQ
X-Gm-Gg: AR+sD11x5//0zdddO43jzUhnvswnLfWrH7NLd0lHgjREeJHOFfH8YDRS0s5H/nh//iW
	TdJpRsNfzO8iJ7bVM5DCa6J2yqLi2Ftv6V8cm3IM5exjf6QIO+rNwi0pt3GUE1EJDOu2lF6QSq7
	urUPmjWkcjnM/lQ0seHfLNRyVyLLcwcDxBv/qlAeU5JkmngjzJEKCD8O4YWqzgB59Zzu7teoSvg
	iq2GGaovDzpdPywV4nYW3Bv7nDdQq9Q1kjNmwD9sUQzuMSnc4Tr3vPx1O+t4ZuWHLzfGMURCeIc
	ZaT5dOKWeeRgNfnHBdszjPq5MtsClAvckm+ntdePxwAu1HBuhNlcvtgJ5RVZaUg57avkC1AKtpK
	ckoOE8i7K/MHAffNCrwqXefBF6SC0x3+PrAbTUO0jd8kelazIJf0yyaA+oFRkMS5warI+XQUpef
	YzSxlYF5CLnXmYoLq5WulHouCTjvJRp5LspRuy7qy4foSwG2feZgp8wIjG+n4LWDSC4LmcESW3a
	+jRisgBoqKHQbZxUTXlJSmBs9AZwz8F/JRy12aD4Q==
X-Received: by 2002:a05:690c:4392:b0:833:801:f715 with SMTP id 00721157ae682-849f4c71f3amr52253307b3.18.1787432153186;
        Sat, 22 Aug 2026 13:55:53 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cabe2570fsm14237647b3.38.2026.08.22.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 13:55:52 -0700 (PDT)
Date: Sat, 22 Aug 2026 16:55:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Ilya Maximets <i.maximets@ovn.org>
Cc: Norbert Szetei <norbert@doyensec.com>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Kuan-Ting Chen <h3xrabbit@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org, 
 dev@openvswitch.org, 
 Jongmin Jang <payload.jang@gmail.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.125b8a9cdc49a@gmail.com>
In-Reply-To: <86c61c39-901e-489e-aec9-fafe639276e7@ovn.org>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
 <34c64d08-0484-4f3b-b61a-ed68115d01a4@ovn.org>
 <20260821170950.3e278b1f@kernel.org>
 <86c61c39-901e-489e-aec9-fafe639276e7@ovn.org>
Subject: Re: [PATCH net v3 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ilya Maximets wrote:
> On 8/22/26 2:09 AM, Jakub Kicinski wrote:
> > On Fri, 21 Aug 2026 23:45:41 +0200 Ilya Maximets wrote:
> >> Unfortunately, this needs a rebase now that a conflicting change
> >> for skb_zerocopy() was merged:
> > 
> > Ugh, I was supposed to merge this first, wasn't I? Sorry.
> 
> Not a huge deal, I guess, the conflict is mechanical and the patches
> are simple.  I can take care of manual backports once we get the
> 'failed to apply' emails.  Just a bit of busy work.
> 
> > I was hoping for Willem to TAL since skb_tx_error() is a tx ZC
> > thing, now I realized that he wasn't CCed :S (please do so on v4)
> 
> FWIW, I CCed a few people on v1 to have a conversation about a proper
> fix, but that wasn't fruitful.  So, if I were Norbert, I wouldn't
> include them for the new versions either as doing so always feels like
> me being annoying. :)

Having a look now.
 
> For now, the plan is to get v4 of these targeted fixes into net and
> stable and then remove skb_tx_error() entirely once net-next is open,
> as it seems to have lost all of its prior meaning.

The original use case in tun_net_xmit introduced in commit
149d36f7187c ("tun: report orphan frags errors to zero copy callback")
still exists. Not sure you can remove the function entirely.

The bug is hit when this function is called with a cloned or shared
skb. The original zerocopy path through tun_net_xmit was probably
expected to not have this problem.

Commit 0110d6f22f39 ("tun: orphan an skb on tx") explains why this
orphan in tun_net_xmit was needed: a (vhost) zerocopy skb injected in
tap1 arriving at tap2 and not being read there indefinitely. Such
loops are not allowed for zerocopy.

Commit 868eefeb17d4 ("tun: orphan frags on xmit") then added the
frags orphan. Since an skb can be cloned on this tap to tap path,
e.g., with a packet socket, I think the bug goes back to the original
commit that introduced the first caller of skb_tx_error, commit
149d36f7187c ("tun: report orphan frags errors to zero copy callback")

If respinning it may be worthile to link to this thread.
