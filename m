Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892C3BE627
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156736; cv=none; b=Aak6oUu/l2Z5hONl/3jCSkORawEhNg8W3HjT4WBFyuXyQx3Ra3iZhuiqUi5nbBqQX5q1RTwRXclcQlc4+ofZzcUBMULV6AhQdZXAVWTl4QWBFhy+DI8eU2cXjVTrPoZMrDmX86OIDWgAt92ljeMDp5Te6y8CJfTfM8wW0tK/DI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156736; c=relaxed/simple;
	bh=6rMeicBpUt5F8BVehiQWTpyMMzG0no6q8uCcA+Scuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4Xx/SIhc0EnveBhLDctOKhXuw/O1N93bdp39X7Kg0QjnKMdk4VZVbLoSm/WxLE5ZtA5t+CO7xOMPMZnmcTNZjtLZHLX1biCSHNX0zjMdlUUsqz7wS9kTH3/KlNr5ipnLpv9ektbS7ZiiOV73DfdwFCVVnmG5rX0/5wxN7VwNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=K1FLaTHr; arc=none smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="K1FLaTHr"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-32b2e778709so461163eec.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790156731; x=1790761531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43VperOX1CwdvhIAigjWcx2H8QnkE1eqCOgWjrE0Za4=;
        b=K1FLaTHr3rcGR6+JuI3E7QETQarbRfRAEscDOUfEzj1pd6MxM1KF26eNd9w6HEshAH
         ctD9Mnpij1CyXVucJ0g2lLrP34jaA+prsmF5o7MRVkT9Fd0Tp2hrlxiQTLBAUN4La+TH
         JRtfQdY1bZ51qDpQ9wtP0F8SncWtktAc14oJ/RE3/RK3Wbnl52F8PIxMeIPD+t3t6SD9
         VxHHMC8s8TWrO9j7iNn0xKrfgD0VNhKM+rGvfqf42PU0xCgxt5ikUcAylrnyF8B2F/UE
         a2dJukI8Rh1RPifc6vKRWbmoDeJ76Fk4jKlYhEgepCj2Re9xO+u60Fv7/yxsC3DnU7cT
         +2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790156731; x=1790761531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=43VperOX1CwdvhIAigjWcx2H8QnkE1eqCOgWjrE0Za4=;
        b=deHJNT7RY74t8e/eKaNZaVSDTpp32n0dHnDlTPxJx0sfGV7o1b3S5jmriIaHlqTYsh
         IenoVzeTUlVeWxp0cbaNtlb9LKV4Svf9i+vfjCV7o856K8YFyJcCFM6GwpWHLXz/3FY+
         AzKDXsX1O+eZZguhsTgalb2R3gVec841fUOL1fXz93cup3Rn/rOWcYHliLZyrhv25bHB
         HqEF4pS7xYKNUlEZE/PQ1daV2GfY/Tl0Gu2nwP4Ubn951VpbRPEH3uB2RmXZ2RFFx2uc
         Uoeu8FrBcwWyy1jyHGca77O/tuasE6yWe4z2sWNn8kj7ZG1QkKI4JxTSmH1FXkDT/wCo
         YdJg==
X-Gm-Message-State: AFuF++n/9ZbL5hPR0tlKibRK4UdzDe91/rgwcANmBxyzrMvAoICtT/Q7
	dSdOOK4T37I/D1ykvy9Scf8xkEJC/bxshxLIY8desZMEuHJTvfDJNQUhPsba0U3psajMCe5jfox
	TQ6VGi7nB3yv5zp4pdWuxDs0BD1Zj1ge0lXY1WfYw0DP6aR9ucPIqO2P3DuVTZtWptMulUDaC/H
	ajHA==
X-Gm-Gg: AYBFou0JCuoqMp3L2zkTbXlaPjpVlS7Xf0wQayYywAz/X0+I2BxtzmNyCDQ76Dui7Ax
	VXmfKOT9VvzuRFYrz868HkG5ytFCPFbkdl3u9ckRHrNsDKZvuJOXRJHUdq9Oc0sUrMgl3cqim3f
	5WznmtvTqLQhvLtl7rSibGfuUln4qOKMvfp5AyDuxV+tKKR0lSuNVxkQt7rKT2E3CuuIKlxbTCC
	WdNEh/oSEHaxbzVC/3k1EZG4iiPMnLoOzmlhPvfLbIk1B2u9bo2Im3fjJ5XmLRnzydJ7OGDd3A6
	tKByTrJ8z644lPQBDT8CQMwtEtYkmZCVqq3gh5+/SdbmjFj1uAalzcHDftpoDOPrcOXJS4MhP0E
	W99Gujjf+LAxRUG68QeCqldqvvUTau9ueWNfI/iyp+OV2+keUa63BL6vGWx7eJXmwbAWkwxhF2/
	7TClgPt2P88Vwq/lGHsPZZPtr/EVo9ljPhxpdZrNIFzOXPnY1MgcbgH3Fe9kSlCX82vVV/8wDKu
	lSNV1ZXz+DnMTdhkg0YEg==
X-Received: by 2002:a05:693c:8950:20b0:314:75d9:4751 with SMTP id 5a478bee46e88-33e8d9c90e0mr2012458eec.20.1790156730630;
        Wed, 23 Sep 2026 02:45:30 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm5386068eec.12.2026.09.23.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:45:30 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
Date: Wed, 23 Sep 2026 17:45:17 +0800
Message-ID: <20260923094517.3998941-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.2984a0c37a5cf@gmail.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-3-wang.zhan@smartx.com> <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com> <20260920131231.3610688-1-wang.zhan@smartx.com> <willemdebruijn.kernel.2984a0c37a5cf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 16:36:37 -0400 Willem de Bruijn wrote:
> Wang Zhan wrote:
>> I tried it: https://github.com/zwtop/linux/pull/3
>>
>> It does read better, but whether to resegment is the caller's choice: the
>> qdiscs strip the GSO bits to get one packet per segment (sch_netem.c:443),
>> and a device-derived limit groups that output instead - which sch_netem then
>> drops, because skb_checksum_help() on the first segment rejects a GSO skb
>> (sch_netem.c:538, net/core/dev.c:3626).
>
> So this is a rare netem edge case we need to handle.

That is only one example.  I have not checked every caller, but at least tc
sched tbf/cake and the OVS upcall are as well.

> In the hot path, we should be able to defer the decision whether to
> segment entirely or segment to the capabilities of the device to
> skb_segment itself.

Deciding it entirely inside skb_segment(), without passing extra
information, is difficult: the oversize case overlaps with the cases above.
And the features we pass in may also have had NETIF_F_GSO_MASK cleared, so
it would have to take the device from skb->dev (that should not be much of a
problem if we only handle the TX path).

>> The features cannot tell the two
>> cases apart either: gso_features_check() clears the same bits for an
>> over-limit skb (net/core/dev.c:3843).
>
> I wonder if we can refine this instead.

Maybe we can add a bool to skb_gso_cb saying whether GSO output is allowed,
and leave it to skb_segment() to decide whether a GSO packet is actually
emitted, and the max-segs.
