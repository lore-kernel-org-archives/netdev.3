Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94947248893
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792106068; cv=none; b=sRaQ5r7HEYaV/YL1sO8F3DNNef8CNLy5M+6PB/4k7qWQ9h7AXDNSgfGYv9RlbBCtJE+MkF3ujaQ8V1SV1A7AiIH1MKamUxAwRW2P3KBA0Pcmj9UeZtPZmBjtCWZKynPloy7xb+9K8uYIic03V8pYiGLXuIIhFn5PCTWSehHjPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792106068; c=relaxed/simple;
	bh=G1VWVzqgtNFSdZ3tdadaIkj4EZd0Y1m8BQMjwsAXmlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iw1qXKpjNy42vSbXKprd7upPOdBuyu+fHTy7lwrovCHij10fTtQow5Xoirudn4iPNmUkUpzpSwIhpfU1MVSrnwCwoWC2QQuNNIEgDvE2Q6Roy9VXpx8AIOGrW18eP6Uth7o+yMPOUu95iuB8EocYrDMH8Wv9I77/LUk6qUGGIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdP5ygMa; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdP5ygMa"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35f036b17easo877701eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792106067; x=1792710867; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jOoDNdgbqEONnRhnyuTwsgaYEHRZvbrYhwZMQUhYOFM=;
        b=JdP5ygMabZzBXo/EhxT/jY54OXwwD04A5YDYkGO9VGJ8b8ex+IiKtzkqK1jeYDubXT
         DzU6iWEr9axaUr/iHLODfTVN5O3TezmRwrPsZU8by2WJMnoxetK9POQJFnkjC0jgayPz
         QYKL2vy+oBJgItG/6kiJ5ONqpgIL8Dmplfw8MDVc8zQg/gQz3gu4w+cqigudhqv6d3L0
         rsPbhGUtoJ1zEfevk+KeE++FF+RQlb362IOzvGaAgu05XXMsnqViaSH0ywdZyprgaKpL
         y788N0etBWTBQDpjuzCb3BRLz4/CR27C3FfHAOXhtMm0VcCiy2fbSRzd0qJHdfAssRSU
         D2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792106067; x=1792710867;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOoDNdgbqEONnRhnyuTwsgaYEHRZvbrYhwZMQUhYOFM=;
        b=MD2T+9osbVR6G1anZ9QeXsJUcMClUfiTG9IBgZ4nOOAb33PoUQNWuZ4v7t1o2sACyH
         aN6cWDRMFefxAPXxXuIwt6Y9IklwBRBqsoXMs8RUcyCqZuJRbKFtDo725ZI7JKf15VUN
         +iszixsvREFDyC7eKZKQbb13byS126jqnVs87uSD/bu0rO0EzkK4uLyuIMtVCv7GqH18
         hMeZ41n1gYtc+Ha3v1I7cXQpmNT7oOUijYTPnOeWE3kELy+SAAvzSuxjlllhVEThZ0IL
         gCZDisqwK5u3MM/A/DxOoPngdsQ8EF8MvmedsMlkF7bQTME7iljempIjyQXD2G0khgNc
         TtMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwV/g2dgzeDMCq/FnSKeoqKqbsffBuO82BzS+eNqcCMabURWYG2+hY3C5iQhfPKV6JvdwrqQBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd+V9AWPxjrCqgbS61dMQuwNb3EOaxVda6jDp+xuVM5JGrbkyM
	ZO35DE2wPi9WzUry+8f1WIZya62XIo/9APYzHwzp1oZ93+29DWhOyaaP
X-Gm-Gg: AYBFou3rbZBHRDguLzmPKJVR+G6dmlc9U4AdVnDSeZjPfrGclrnKfLN2xaC69/zD/4n
	YG8Arb2qZ/rjfVaKuITi3/igin9wNStQY5RMs85Gyt3o/c4YnJWO2RIHki3/xhBwdzxBCklAOlh
	w9BhsT6JjcDSCX4QTkG+IvNPdccpg4pH9z01LunU1G7SE8vgFaAIgjXOGj4Rv4t/sPf3wL/w+mW
	fLNhv7+kmoXEJtYwjXCQXu8Ge4N22CsJLnanMZq3dzB8VdMqD24EzxRCeKBTmbOynRioJ+xhKQh
	xdx39fN81W0EB43FfnEUsZ3AhDKcxYO0RGBCNDhrs0J1LQHJcOJXNdDW4bxXhYpe5keHUgUq3qb
	QtWFPUMFkLeWMP4NVwCNdQAZ4D9Jm2vIUBGu3p4tdAiFAdVdr7QkL0SPi5cLz27ABur6X1BZx2+
	Ak6BXU820LL8s/OlbhChV1KIa0P/YpHkD0fZMZFlK7Ykt0wWeXRKn4lMwJQzAIEw7SyzIV2XMER
	l6I3eAe8DDvvEq6RJZdZ5qbnZpWeZq0e1kJXKLtjmjNwz3MygOiEP5roUqgIPtFk3UcfaN+O6Pv
	EWe24mYs8O2QEpeNGC8yFcQka4ugia0rDM9KQG9SFbVPnrYkbT6h+9RIFm2s+//5jN2/mvs=
X-Received: by 2002:a05:7300:d191:b0:353:7f50:a99b with SMTP id 5a478bee46e88-3537f50ac52mr27374925eec.6.1792106066501;
        Thu, 15 Oct 2026 16:14:26 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:ece0:446b:100:5c81:b436])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm1262967eec.0.2026.10.15.16.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:14:25 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, sashiko-reviews@lists.linux.dev,
 linux-security-module@vger.kernel.org, network dev <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] calipso: update payload_len when removing the
 CALIPSO option
Date: Thu, 15 Oct 2026 20:14:21 -0300
Message-ID: <179210606199.96599.8994346249690707193@gmail.com>
In-Reply-To: <852c9fb6-6217-440a-968c-b5ab3e22dbc8@redhat.com>
References: <179147329205.58079.5847298721173675285@gmail.com>
 <sashiko-outbox-165773@kernel.org>
 <CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com>
 <852c9fb6-6217-440a-968c-b5ab3e22dbc8@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 15 Oct 2026, Paolo Abeni wrote:
> The above looks like a pre-existing issue, the patch itself looks
> correct, right?

Hi Paolo, Paul,

Yes, the issue is pre-existing; the delattr patch doesn't change it.
The skb_pull()/memmove()/skb_reset_network_header() sequence quoted
by Sashiko predates this patch, which only adjusts payload_len after
it.

I tested Paul's idea on top of both CALIPSO patches (QEMU, veth +
br0 with bridge-nf-call-ip6tables=1, SELinux + NetLabel CALIPSO
DOI 16):

- without it, a bridged CALIPSO packet towards an unlabeled
  destination reaches the peer with a corrupted Ethernet header
  (garbage dst MAC, ethertype 0x0000) and is dropped; an unlabeled
  packet towards a CALIPSO-mapped destination never reaches the peer.
- with the nf_bridge_info_exists() check in selinux_ip_forward()
  (plus a stub returning false for CONFIG_BRIDGE_NETFILTER=n),
  5/5 packets are delivered unmodified in both cases.
- the routed path is unchanged: delattr 5/5, setattr still adds the
  option 5/5. W=1 is clean with BRIDGE_NETFILTER=y and =n.

Paul, if you like I can send it as a separate selinux patch with your
Suggested-by.

Thanks,
Joas
