Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F792F6562
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787509130; cv=none; b=HFdfmT63MYqQUuCS7QoS0i336y4nQGoTGEdAzY8q9qYNKjyQ0R/toCiJTUhAxnwU5Wp+WS9O5nmZy/C/f8IEYPBx/U8CFAxUK+Af+ln0Xz9ZdUGlSOeq29NXom6KcvHkOVXhJ51ZnfXGHy3cPl11NMnMHZzNKw7nEX2vHAQ6L70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787509130; c=relaxed/simple;
	bh=g+sd4lNiCZOp1p28a8RQtptNi1P+0h/OWNviTk15Ctk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UOVafnlkp/buN46EJtqlWpc2iE8ZyrzT9Xmqec+3U+32US0pR9v4qKw/JV5sAMMKstWScNk1D+tmfUe8BVZFsCCnOI6W1FFQT0q0oAyDrljnXQX6kGr6kjPkb7acFivHK6RFu4MjIx5yM6fjs2XqIMW0SxX9bpsYfCZa1p8o7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjwzqrCs; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjwzqrCs"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836c91bd782so33742247b3.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787509128; x=1788113928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5voTwoiOzEB0n6QKIa1WvWhYAdsgC01K55aSlDxmZZk=;
        b=gjwzqrCsv7REicKbXIvy1MftouCOVdLfFQH7FRdXQnZvmKbaiLLmqnP2k5/omLsOOc
         cOZ1iy3rM0GsmYAF3pFUA3zPGz/8ub0W7UOt5QAVfz3tVnCzqw84b7JVNFLMVN+4eEav
         cfMD4aUUlW3m/dI5Nax2Gw/HTsPyjl4UQH5eT4AlwdhUCMpMdQFT+nrsOu6zWV4p1go0
         trUgAUgA2NRYxR2bE/un23YGG4FMxUrC1FzvT6Zu2wrWTB+Dq1X/twRm0bHm4fyK59wf
         jwVmnJvmIF1dIhcuNDp/fdopwD+NqESb6KM/GrmmaF2q6hgfRaXPyPEi2XmD0GQ06mUd
         4mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787509128; x=1788113928;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5voTwoiOzEB0n6QKIa1WvWhYAdsgC01K55aSlDxmZZk=;
        b=BxVA9OKUn2312vrJu43zQpLEPwf+sSrTXZPuIjXDoRNwGWGPn9aEScWM13114RsdM1
         P5XUvqX1lpMblW4f4noCJPGlAnDH4gVwZT/df9SNi9Yen8aJfvl4O8EBZgdBuNopFyNV
         QBj4mQbngfUYazdcnGF0qMenZ5rnObTeQMSEtx5gXcdqqXwGInMxKY/Kzk3RF5e0bsvs
         BL8bGOETd2viDd8CAgMEvAIHtmrZBR7Zx0dzzegabhRG9JLkxUabkncFh3+gRE1KkXX8
         FrnZcrSGhDesViJyk5mgEOggJ9pJIeDRzuSwRsIFfILSRE78US9hTMuubBOCl7oVv4Kr
         jJMA==
X-Forwarded-Encrypted: i=1; AHgh+RoX9fQg6gDOfx8BQU7EOcHxssr+J77xRoL9ahbwAjWwHPYmvWn5MTLFpsdhm0QYaaK/SwiW3Po=@vger.kernel.org
X-Gm-Message-State: AFuF++lTMKFCdwhXks5aYeDHAeguOwsBoU0IltkV0LvQiZykBXgg2hpq
	9lXyzlRaQAX5Obt5dXAgrAdjsaJxEnNUQlknqNYkdRwjAQUBTAuWJYAd
X-Gm-Gg: AR+sD12hyknfBA40TNcgJPp9RevZnCdS1poKhNOE/yLHAT4cLwD1lPRoZszsAdn4Paa
	22H9k1b0Tj7v/5UURDx70teSqh+k/MsBErs8vj6Nzxoqoyu20kNlZS6e7pZ2hnEeeKVTDybW6FM
	boLhWjUxRomv/ohEiWLgfejABnQZyOHG964OWHugKKel952JpakwNEDTEk/2WZ6mgGiCznFIrRL
	rNdcT1xWPICO04/SuIn8vXiMgi5iq7sFAmWdhelcRcVxlE/6PmZ79ufIlHdN27AzoMBMHg6by7t
	5Kt1mS7KEAbM5LlrhKr2h8jHEhJlUmAnvk3ii4l0qgExyONxzvEnvIzHaZBZ8owBwk3R1o6b53T
	2NuXPsdrvFdz5gZ449r+Rgtb5zUNTwagwocu6Zv3ZQMyRQeDcHKuITQ6iNAMH+9M3t+ImBt7fBZ
	vsUyYgW3bzXrXIeB9+x2qrzCNx/LgVXImOL43qF1VT9vCwGWS2Lr99aQY9Go8dsBXJkXAMavPFu
	FlNp+mwL3pq3p9UmR81n1s7MXuzd3LsXMzJRc1g5rz23rtro8vy
X-Received: by 2002:a05:690c:a0dc:b0:809:ae5:1d2f with SMTP id 00721157ae682-84c96a0b35fmr34169497b3.9.1787509127918;
        Sun, 23 Aug 2026 11:18:47 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac01026csm22491687b3.39.2026.08.23.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:18:47 -0700 (PDT)
Date: Sun, 23 Aug 2026 14:18:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 daniel.zahka@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com, 
 cratiu@nvidia.com, 
 borisp@nvidia.com, 
 kuniyu@google.com, 
 netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.357385e9d8055@gmail.com>
In-Reply-To: <20260822225524.2328465-2-kuba@kernel.org>
References: <20260822225524.2328465-1-kuba@kernel.org>
 <20260822225524.2328465-2-kuba@kernel.org>
Subject: Re: [RFC net-next 1/6] psp: steer Rx queues with the virtualization
 cookie
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> PSP leaves the 64b virtualization cookie undefined in transport mode.
> Put it to use: let both ends of a connection tell each other which Rx
> queue they want traffic on, so that a flow can be pinned to a queue
> without the receiver having to install a per-flow steering rule, and
> without the sender having to know anything about the receiver's queue
> layout. The cookie holds a queue ID the sender is asking the peer to
> send to ("req") and the queue ID the peer last asked for, granted
> ("dst"). Each ID gets a 32b word of the cookie to itself and uses only
> the low half of it, so that either can grow to 32b later without the
> fields moving.
> 
> The two directions are configured separately:
> 
>  * rx asks peers to send to the queue paired with the flow's Tx queue,
>    so traffic this host receives gets steered. The receiver installs one
>    low priority rule per Rx queue matching "dst", which wins over RSS,
>    so this needs vc-steer-cap.
>  * tx grants the requests peers make, so traffic this host sends gets
>    steered at the far end. The queue is the peer's to pick and the rules
>    are the peer's to install, so this needs nothing from the local
>    device and can be turned on where vc-steer-cap is absent.
> 
> Splitting them is what makes one sided deployment work. Turn granting on
> everywhere, cheaply, and asking wherever the NIC can actually do it.

Split the feature patch also? In three parts, one to add generic
extension header support (and all zero VC), one that adds tx granting
and finally one that adds rx requests.
 
