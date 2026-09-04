Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68B3AA4EB
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491037; cv=pass; b=uxojvRerRBUhn616s58CityfD7mMvGWH2CniJPCkNJm8p8ZSqzWatrijF7BEfRX17kDp4Nw0MxEa/GUGsN6mzRzsSa6ZJgMGVbz+Sa9s6ijJlbugHjkmvNi4nKeg/Ci/rClWftah0lhyi5jMoZZd/hmcrHJJ7O/feVT+b8cbfI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491037; c=relaxed/simple;
	bh=z2doF7EPWFGqoPz03TF8aMEAMJft9M8wIvsJEX1Rz0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KR0vZZzu04AJlTjCsBLJZtPDnXkeeWeubb+U2WCKJgdxUplm9IdnFZj4NAkCCAiNnNZ+IOiIThtaMdZKoXi+On+zWHt8l5yGCiXiqzEr9TQJIH24bOoln2xZbch/6w7EDQU0ypKACSFPJnw7m2TjilVQQptxN7PpehsduTkVFeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsPkVhHr; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsPkVhHr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8525efa7274so396621b3a.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 20:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788491035; cv=none;
        d=google.com; s=arc-20260327;
        b=khxB/HMc2IfXAjO56hExj7geb9BebHHhzDVjhX8VnvmIZlZt7oxU6+pu82YI6vUE31
         SokJLpmH6ncnomK7D4yb4IZ7Ahf1NVwPk5vlarrlPmN/WLLq6RGtv8qxCas+D5EDgQL8
         NRcKEkL1SOBLlkpS+Qq6hra0vBoI7soX9STqauDEUZvxbPh05UWjbHH3LdK5YHPBKIwX
         OA9s04AkypedSbLv/wzFV6jJzQReQrGlu02Us4w2xbsL59IIlnNqPYMbMtfjJf/g7p8T
         VRaX7LrmsLqTlXOr65X99FnGkF7A2cdRkYnkiSDPSkntkeW4sqK8iCZGGEd9YRpXcK9t
         jbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z2doF7EPWFGqoPz03TF8aMEAMJft9M8wIvsJEX1Rz0s=;
        fh=9BZMZfuTEr3qlEcb/hhCArAm2i5gVBNEizHKgvpHYSI=;
        b=XUuHQQhJ9GYaiTSnlPZ+IFhLrimorz0XmbawWdw00HPgjdIzaSA5X1sK0OGUOkZDZ7
         jJtM04M1IF17ynUTeOMUEBoKXw/R55qVkCEoKUUZRgB9CEVZ6zAXSjJnHktGCsI+nLle
         KaJmItlvUTiLh4v4ytJbWucF5eYEl4as2SCJTnYRF8M6foeOW3vprt21B1KwYE9kF+8F
         /gR1o3acbAyvNRY0iy8kziE8FKM8SkSirmIRV9A2moDzsfISZOkJ7i3cQ6/g/saBXaL0
         upZEIt1Ofz0MHkOMQ22juqYKxaww6ciCxdyeGC11GmbY+vCUP2YcLoLmNcIaScLjbcGp
         zd7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788491035; x=1789095835; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2doF7EPWFGqoPz03TF8aMEAMJft9M8wIvsJEX1Rz0s=;
        b=DsPkVhHrShIvaZ8APLjE0/nXsDKm6u49q/b3QZtHl7rIi2AXruYTXTNT8st7c7tabY
         aizr6Ac+d/4R1ZHe9HgbZWP8ZIXMwmpivW0m8Z8txhurEgEcLM3bizno16whY7GW9kph
         AnIgZzwIF9BnGy3hSxKbxp/qv1Sk1TGfvbqJ/9uyqFxnO2fJSSeYwWni/aanHYpTYTmz
         QL+5LPMowzZvpFjAVOnJ3LC/I6lzj6NBWQNDAV/3tEyK/vj2bRhjbHG3h4OcjWUf2Imx
         ghdvW74ecLcLQiq9yiZ9nT8+crUUuyIjz0kXchIxKNe50DVG39p2Sp8DCneixF3av1qs
         HiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788491035; x=1789095835;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z2doF7EPWFGqoPz03TF8aMEAMJft9M8wIvsJEX1Rz0s=;
        b=cn6+9UUS+09PRdJt33jehHGcvNEL95vjbzWebiz+l33M/HUu7c570fKe5LtSnJTaCg
         Y3sMEO+nONXAjFpTv5r3BQY3KH8GuueTJ02TQUS357dqINC19DH2Ko63GdefjWwYwgIp
         4wxxyeDHHR/yCOBQVK6qECPV9LDH5GlJ6emfyiq31wt6j+DMOMXuQyryzjAEpk9pB1dn
         xmRUUuoM6kj3zPI322qlYQuukQHZvTEziNtkBl4Hb/W86j65jEHYfLdTwx0B/a86vvax
         yTQJjfrsKGDNCa4OgGNSRMl5ZqVcrRjhpveMecjuYg9aI5rRdtDTaO509+Zqj3QmOu4g
         PiZQ==
X-Forwarded-Encrypted: i=1; AKwUvBww9MGcD012kRHNDn4auwDm1j/kCe7YvhPfXkDphp/PyA42okWU/0sLl87IIxeS8iy32h6Dm6c=@vger.kernel.org
X-Gm-Message-State: AFuF++kMGSBBo7VlOvHebgytAkS+xqSV4NcLGM6g2xW4LcvbYl76lE7I
	5Ci5bCQOuu6wlPKupPx1hYKaIEH4M14HoRel6IP54MketsVvwLl6EmlHU+cc0IVWo3sN00ooN9M
	PcqTKo8hwfuz+gOHAxNT1jGaqPas/ZRI=
X-Gm-Gg: AYBFou1CLcyPI7ajSLw2geFQJqERAY7qJsoegHz1f6UcB2DySacdKprI3f7WKw9co/n
	SAJUQLJlf/bZmx14SPtMkd9DfIgUDHTyV5Bv6oH84VoBHFi6sLbOjHQYOhc+F4Ajgn1OFnZ9jqv
	X2XY3EpI4kqEXIzj2xkvjd7WxuSEruc9HeE7UNSnig5JqeZhvGcqW2L/FdMJP/Bx2GCdu8G34qu
	Whd2AMNXiSPRVfGHtFqEtttofDzGvl3eDoEasJHZO7vHirWfQgGIjNN4gDGOt55YPKRMdCDEfwJ
	F7ZbT8RReyntVvojTpn7Lfktk6BOv849xqnxriPQzlzaDpDeDQuL1R2mtFTKB769A+8kNzqAAiW
	W6UKZFVHLqbLAv14ztbK3sHrPSTxpsxlDAoKL6HtBumrSajAF2GTakZE8
X-Received: by 2002:a05:6a00:2c94:b0:857:727c:a1f2 with SMTP id
 d2e1a72fcca58-8616907f6e9mr4805768b3a.20.1788491034969; Thu, 03 Sep 2026
 20:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092430.354186-1-phucduc.bui@gmail.com>
 <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFD1+GJiWdyxiuGVRzKjpCUfu3TQHYOLnOym3hHzOM2tg@mail.gmail.com> <GV2PR04MB1173931CA07AEAB48339FF71588B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
In-Reply-To: <GV2PR04MB1173931CA07AEAB48339FF71588B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 4 Sep 2026 10:03:42 +0700
X-Gm-Features: AcwNN1WpmhDLd9SGZogKk2zYLLCenPMMN1VDDLJIPFCLsNZLZHavDM4ZfmsEdqA
Message-ID: <CAABR9nFi06-7=uHmOBFGZv1eUYCskv8WspOdUxbDuQ6vMk68Dg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
To: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, 
	Stephen Boyd <swboyd@chromium.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> Is this a real bug that bothers people? or just an improvement?
> For real bug, I think the patch should target to net tree.
>

I consider this a real bug rather than just an improvement, for two reasons.

First, commit b86bcb299092 was a bug fix and was also backported to stable.
This patch fixes the error handling in that change, which incorrectly
treats errors
other than -ENXIO as an absent optional IRQ. Therefore, I believe this
fix is also
relevant to stable kernels.

Second, the current implementation can silently ignore -EPROBE_DEFER and
continue probing instead of deferring. On an affected platform, this
can result in
the PPS IRQ not being set up, causing the corresponding PPS functionality to be
unavailable to the user.

I don't have hardware to reproduce this specific case, so the issue
was found by
code inspection rather than a user report.
If you think this fix is appropriate for the net tree, I'm happy to
retarget and resend it there.

Best regards,
Phuc
