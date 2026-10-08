Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68131C3F0C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453993; cv=none; b=tpOrm0kusWr9/qlV9QKHaYhTONN4E8kxdDO/sTyZXDaykucLzGhdGaA7usW/Oc/tCzTz0vPbWXDZlhciK1V37muxKQGCrk28PU2zmcTW0Q0S0jO9ewg5xbTwJE3boU+/Xz7PQaOPne8x+W7GdFl4PxTMnZkPNO9R8vpcNNuZAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453993; c=relaxed/simple;
	bh=JWj1nuzQ35N6wDOjwCmlhSw/qBTHjvsrFfWUXl3xZZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCofWgrefJ5X73+0lDrBzvLfpHJaDXfWCWVcO/J+fCCfhPD5v3D3cFa/s5bNV5xDOpdFiO1U1bIf1FFRp1iF5LuVy9Iz6bMV8qbDn214TYImnxladvM+i7r41hJ7LIMVNZOGzqZC7G1erxlRDDRFVn6ONVJ/y+15VD6EDM2wR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itEQ3qF1; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itEQ3qF1"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-154e9d2d979so2985411c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453992; x=1792058792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCf6grt46A4djzAcjuzxJT4IZiodM5ZCyPT424FBF2c=;
        b=itEQ3qF1S17+BeT8nUNlD3RSVNUSW7LqSreVag4odzNPR4caEk2KX8LIMjnyB4XQ/A
         rx7VMmX0oGGzC9nM6HS19s+ckSQw1jmUm0EPPjAIS2kUgiyvF9Z/uL8RLKkkMicEUr2P
         QU/3CgOdKA7sln7StajzTyWutALd7gRJtpppY4zN2onlqHzb+DLaK9Hi57oKITkNX216
         18uv4G2HAHrHFW/1XvsdAut+9OwphqchICqgGqBMwtsIPPvP6tAX3i0QDJbY+33pe0il
         54HKN6nZCQzA53Qg23VBfzAzGu4dyKk0ecMKk6dJqcTs926UPXgnM/mJaiJlqMdnOrXb
         qQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453992; x=1792058792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCf6grt46A4djzAcjuzxJT4IZiodM5ZCyPT424FBF2c=;
        b=gKz2M/GQhR8WdD8tvoDl6xEhIdfoxvJackHYICO6oxI86b6NLpJFxjT0Y33foOnzWY
         /9WfEZXqjgkyzOPNzOcZrYXC8M/3IiNqFiAYEM6Y17/uORz2Jeb5yI2HLM5w9eBqDRBA
         YbdA4risLhQgZZYuiDtYxG/W/0e/cSGqRcYIwLdKyK5AW/Aw76IvOYd4yDdj3BfcFO/q
         1r1iu32vqfpgGq0ubQfTVSpDDSHK8nx77brdtAN7KRi9Rda5DldVbPijkQIy1SbDEGkz
         SGzHaXPIqsTN1idvqUVGw7fjp9uVBwkzBfVuuI7ZGLqRr0ie+cr8PFLJXs0AYYR2ZRU5
         EYfQ==
X-Forwarded-Encrypted: i=1; AKwUvBw28ypIkKmoMkTbiZBlMyhq+RtyBKk4rur+8x3hC1wOz3wGEGnmZ4E/OW4xWZzU4qM2G+yXZWU=@vger.kernel.org
X-Gm-Message-State: AFuF++kxNm+s+k0Cny8Rf2vlXYQqZ9HdVvSpjICPp4jxRyio3F5/YZQ4
	c6EHMGsVgEmjPP/PFeT7b0oPnY0Fdl489rie8oatGL1ksQZqvTXNnN55
X-Gm-Gg: AYBFou0zJdVKCEKLH0SIpOGi5I3xangaSwUSb6Z9Y43PqMUC8IOSPYyWOsCm/GXP6l9
	+sNBZt/rw1dNtd9MnmMzj7LXN34svM/w2MVL/cQxVjzQDlhXDDxwS/V+7TN47qOI4OpcDSKTu6L
	22X4o10QGW94dUxIMvJ+4EZ+le21fJBaY+piMoyRNi17UQ6TCblBkQ29wiQtd+Vmjwf92rqoCWg
	xqUmmqcMmhp/5SdT1t+iiinNxkHXYPjPVwd6miMJNJQ9zpW5CkJEyon05pf330FxVXmkLxJZRq1
	YTNvHfyhI0og8CVJVKRthJJKnfm5BbDRtlDBs7ft6UY8Xgmlgt73xsQBaFWK2/UXqcV8my9RBE8
	8lFEC3DH13l9sSBkbrk96/QMmFC6YU8ODZvHtLRdHLsIWMXGlfS8eSIrppkLqAQhcXizXKUFeOM
	jY/6uTcLa07toCnXhdm6/A+aDPZXIeyjox2CK8ShCvT7iywqekUaxiaxKp/xkv9kDSEp5aOqy7W
	XwjH35k4ZTvuJQ3UC8=
X-Received: by 2002:a05:701b:4584:b0:155:4a09:a228 with SMTP id a92af1059eb24-1659f86d47emr2222835c88.8.1791453991594;
        Thu, 08 Oct 2026 03:06:31 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616980c3b7sm12992588c88.16.2026.10.08.03.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:06:31 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: Petar Sakic <petar.sakic@ink.fish>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 15:35:20 +0530
Message-Id: <20261008100520.104205-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com>
References: <CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petar, Matthieu, Mat,

Thanks for the feedback and confirmation!

Indeed, since the bug predates e00b63056fb4 and exists back to when server-side
Fast Open was originally introduced, the appropriate Fixes tag would be:

Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")

During our testing with simulated network latency in namespaces, we also found
that when the 3rd ACK arrives:
1. check_fully_established() marks subflow->fully_established = true.
2. But within tcp_ack(), the underlying TCP state is still TCP_SYN_RECV until
   tcp_rcv_state_process() sets it to TCP_ESTABLISHED.
3. Therefore, invoking the push in subflow_state_change() ensures the subflow
   is recognized as active by __tcp_can_send() and immediately flushes the
   queued write buffer.

I can send a [PATCH net v2] with the updated Fixes tag once maintainers review.

Thanks,
T S Rameshkumar
