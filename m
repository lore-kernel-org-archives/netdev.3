Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654E24468C
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172474; cv=none; b=BdstJ8UqsxFwRBNr+iyJRGZ7dlO5QSHBNbSLFBYy0mTc+u/yQ6jrc8GffLJ0dJWJpwnl97uyV1FfjRK5b/QMYmdkRXEhoPkNXdZgMABHzfMnBgezkDSwhLY731emlSPA28e7vofVawPnDmZXHtF/WCAecAZ2YWhim0g4x0YDq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172474; c=relaxed/simple;
	bh=hjsojklkWTvCL4jJhphhchqci2dixHgONZ4YVxk4b8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACW76EfTLJBUxiKD5SGnNr1cTyb82PeGfTrkIKmTNRV8qPnw387ao+Solp7pg3KHcGRu3oJ9IHN3+daUU3gmo8f6Z3ZZzGCEREiAo+ZxBJjlRGxlAXbTBGogbiieccFakA0VIRdXY5SnLRq0Jf1AESjsLv6eAxLP4fOHMvdnv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg0E2KQ9; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg0E2KQ9"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e050bso1239368eec.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790172472; x=1790777272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hjsojklkWTvCL4jJhphhchqci2dixHgONZ4YVxk4b8s=;
        b=Rg0E2KQ9N61Lt0IqrpRrc3g0eiATCMMt2addFmSU4eaBvy7mYeltqU3wgRykCmHFRD
         4BGFq3AxcVNjGWCM6E9eOnX2Y3yLhCazwljxTQhvOvnAlKo4P7GP3sO8WP07kMGPsCrx
         bzPuMsQTmonz83jgg4wdiwdrYgQqLn1M/mXa3TC7NB50BGLjeE8PVl4IWRUOGBtfgYsH
         SCEYDwBmFX33VVMO4Pe7jmtJTlSbTpUPOid2P/b2DXCXRIa8X8TxGctPZMJ3oHOczt+k
         jcOrqZ6tmuTJTs9Q+NhXRkRz8LeMbObT96WgpvHpKh2+q5S0pfkuPvl+ghrKM/y5PY/I
         P+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172472; x=1790777272;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjsojklkWTvCL4jJhphhchqci2dixHgONZ4YVxk4b8s=;
        b=cKMbfPe4RYWY2OHEYwV/hS/WCoNrRB5DmLK5QpxwhyfZhMlhUSfC3MDY+MM54wJXp3
         TL4tfGS6jYV21KP7iZ5j2twYZHAKwTqVeehCQN9Uiucds4P9QliICqFGD4SIZyWlseEe
         JyVYMvobnTfDyGl9ptLa9wtcgto4O9C+/RUc7XAZuPaHyrTzXljEmXTl78iYkB3sBFiQ
         mGf3rxtciuNi2Fsgg9IQiVfUz9Ea8a59VmlSRwgHJzAWRyHa3JSWq4F9RXYI4xzP+L8C
         wtpGW5hecMXbtlJ5A6lx6th+jFSHTHAr8v/BmCrumLSRzC98AYw2LLIUPFWrWT/h33Gx
         NfNA==
X-Gm-Message-State: AFuF++k7Cvnv6fXiF3SYdwphqms+w8+DmsHvuFj+fuKz4na9KmwseYw7
	qwsZX/ZyYXZRGE1kvqTUuJLf5CfnSd2g6gfTYhO9iklv9D1GKpU7i91x
X-Gm-Gg: AYBFou34U7RBbL4qGIDqhjByHbslF8uASBS0mOJRKMabyhY9YiGsGiAkCmqqiCElXmA
	BWNKYQ7oWD8d6jHXyVP+QsVkKzf40Bnbe0qEH5VdngDbVfzdrHokn6Fd5Zx0gYRxqVqck0bp+gz
	XG3D83u0U3yI5r858fj1WdwEnTXmBFTD7ZhytaKIJPlvxfA5rQG/dmRXym3rYyFjarqgHgLaM7T
	cEkg9CzIP/o8zBMra2WD9SOUM6DcK0Y9Oo262KPCMFDpHWCM4xbF9hbQ+T4FQPOigc8+Uy0lB5X
	qd9gY5s17trwpkHS7NErArBp+WuKZug4fjTzV2qz9bXpqIRXO09jA8JFN5+35oTKwzoWvtwJ/hY
	4Ds3ZzfKMB+QHhZ6hYTaSq+XGpQNqwgF/nuqEGZIV3bNme+uNiynTIRBk/5/0A2jHmqHWPxoVAK
	gdMeOwmuH2S8RNVHAnPU0bBmm23tyay4xAy6HuNO3w07sgZu38BJBL5CzSkeO6ePvrfVVlczrAn
	xaY
X-Received: by 2002:a05:7301:1803:b0:33c:2611:1a14 with SMTP id 5a478bee46e88-33e8dec76e4mr2749737eec.29.1790172467269;
        Wed, 23 Sep 2026 07:07:47 -0700 (PDT)
Received: from houminxi ([61.170.225.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9684ed70sm6100527eec.19.2026.09.23.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:07:46 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] selftests/net/openvswitch: add SCTP flow key test across conntrack NAT
Date: Wed, 23 Sep 2026 10:07:38 -0400
Message-ID: <20260923140738.1045071-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179008951086.2160803.550424027687672394@kernel.org>
References: <20260918144647.2024095-1-houminxi@gmail.com> <20260918144647.2024095-3-houminxi@gmail.com> <179008951086.2160803.550424027687672394@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 22 Sep 2026 15:05:10 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Low] test_sctp_nat_connect_v4()
> can a forked socat child outlive teardown here?

Same pattern as test_sctp_connect_v4() and test_sctp_connect_v6():
fork on the listener, SIGTERM only the pid that ovs_netns_spawn_daemon()
recorded. A process-group kill inside that helper would change every
caller. Aaron already called that overkill. I am leaving the existing
convention.

No respin for this comment.

Thanks,
Minxi
