Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492712;
	b=NexvuNrIvsyvwNQJsgpAqMmED96XN5NzEKYqKlpOUmz1FdEBcsYQF7kpju66ilDtIs23
	 n5V3FjRLFpt8F0CMKh36da8S4O1MVGkvkGtZtaPU4tpwkRbKO7LU8+DeuNtcD5G23kuHZ
	 QRC98NtnE6enR0IhKKExv627BPRQZZ0P86lT0EVd8qYxVmd7R2Ah/eZlMv4cqnv7ZzQXK
	 7bnG/m0IAca+o73aAG/+cC8wYWC/fB0WLTd55HUfgBfznJWxNjDpAGbcRxc/Q0qRrCl90
	 G/3ovaXz/mynK4S3ksueGsD2ZOHcLG5rTU6RMw9i7NiBGpY3j1HE4nGsTTLKSDdvIPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2zmwZoifCxESn5tFMPkCRwr0daLGLZtL5qkvBzc0DLA=;
	b=1QWcIyPjJifVl+qbR2z8IEREg9nbW/p3jDCIBfUuNGf6HXm8EtxO5F/CfzwMT6gZCVQ0
	 /G4JhkWx64QDTwMc0JRDm+tmRw7WxuOAs1qifPPzHtneM6l8EEKr0bdETTLIN+dN8U6KH
	 viV1BZAWyCUQ2uCRtsFKOFxBMAxRVhIQYwNFcgoDHwT1paZy9HY40zYs9x0S1PoeeDkci
	 mn7bqaP8z4pUwOXsWjqwmPGbsSswR2wXx+fgus9ws6Vn9Df83t1WM9kXUAPkJXz+sqbty
	 uzTfc2oXabt+vtZT+xg3nkjoh/8QJpEsv2UDHodQOpRtHXpm8kJFV3RRnmV2BhBe+3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=IqFYPZ2W;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631A606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0631A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=IqFYPZ2W
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917866225aaso28762716d6.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792492711; x=1793097511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2zmwZoifCxESn5tFMPkCRwr0daLGLZtL5qkvBzc0DLA=;
        b=IqFYPZ2Wi7GonAxMyMFIoibl+jVi76AxveoOfJHNVhz+99JjfPl23C/KRYMZPlz8XJ
         IS+bkmRZZ86mXGhGNtCQaXfUfX/G3vWcf4N/zh+Y+cfi/t6nRPpASQ23XFnfwROEY+nw
         8Vin2AFY1MPIFRhqnHqx1rVm+teL1mnn54pmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492711; x=1793097511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zmwZoifCxESn5tFMPkCRwr0daLGLZtL5qkvBzc0DLA=;
        b=s4SOL0MUfpkhMrhSv981/r+lOydY8qTAQCLqZ5J+6ehOtGz1uiEM+vYDFScZTB/Qdp
         p4mrXx6qgtMsK7IwMi+NpUxHr8oIyUp+WG/etUvnfhnjJ2/H3RSCrzHo+NfLzX/ia4qy
         Z/mXa9BuO2Y+JevYmJIe7OqyksniKexPVT41sqX7JTM3rVrM+xeGM61HE/2xK3vtDo2A
         0jpS17idVL9WLlWAnJlV0gvt28X8ptqH/mN9Lxa0mF/XgzYZm0Pj5LKyluYrJ5O4i/tR
         1xSsuavKpP8RbdCldZKtYbQ131eoy6fwCOAl92VzVkNfTRg7TNNo5oq2cPu8meMcURKc
         F2mA==
X-Gm-Message-State: AFq9FYKZB6UCISFUkP5LesNxfG3iYLImA1tfXb7H4EVLdpfwqnVf81ZP
	iIErrT6jC3WEgelze84uj7BtFHh0ixBjwdnIS2Im7ut3LGZGAIJ4Yk/fAO0hJOAbVEg0GvVgy/a
	h328=
X-Gm-Gg: AYBFou17/K5srkTI6wC0PcCS0oX9m9xUS7xBd9puD0t878E69Rg9vfltMu2R1lf1ASe
	bXw+o7vjGgHCpXmcA2uQnZzWPbo0HeA2pObJgaeifkQBp0G3NCsIyDJI5q/BVltvvq5OTrPi5cX
	twGTp6FqL+dUscRmImjlDaDJoEl8eVfSFMQ7oWhAuAo7f/n2HPs78jrhKQBcmfDZjQBSW038Xyy
	7wGVmQouequjfEOn4sCzH3V3+GRVb0wsbK0pPzk8R9Xi80+AatLI1AxjHi6+MYUZS/9tkc2oi9l
	hYvD9bbN2WeE286vEf68RYM/5tKfMwdM1dmEhQ0d8y3c9OpnlYybRpszBnindwfQTP5ePwU6X/n
	j2DEtAExhVw+jaWrrTn+O1HFalF06+eJ2WOBZTQag8gfggzRRq9iLtBP7ZQ0GwjkdG3WSUCLU63
	2ZT70SSEPBfPAKOzJqvvHJ6JspcaCa+lKrh6LY/ju2iMIV/UMp6KTyqj9vD7GJ/A3bXkNInPrZW
	mimO7uH9iODivv+Z4z33c/HDBcPbWBmnhTK6yfFhJNj
X-Received: by 2002:ad4:5d41:0:b0:91b:8aad:79da with SMTP id 6a1803df08f44-91bdf127c4cmr175945416d6.28.1792492710804;
        Tue, 20 Oct 2026 03:38:30 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040b4915sm23275556d6.26.2026.10.20.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:38:30 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net 0/2 repost2] net/sched: sch_teql: fix shared headroom and header strip
Date: Tue, 20 Oct 2026 06:38:25 -0400
Message-Id: <QDISC-6HS9.v1.r2.20261020051718@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two pre-existing defects on the teql transmit path, both around
teql_master_xmit() -> teql_resolve().  The first makes the slave's
headroom write corrupt a shared skb and strips a userspace-supplied link
header on retry; the second leaves skb->dev pointing at the teql master
while the skb is parked on a slave's neighbour arp_queue.

Patch 1 fixes the shared-headroom write and the header-strip on retry,
tracking the header length the slave actually added.
Patch 2 moves skb->dev = slave ahead of teql_resolve() and restores
skb->dev at the arp-queue reinjection point, so a parked skb names the
device whose neighbour took it and is delivered with a link header.

Both are follow-ups to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path").

This is a repost of the same two patches; there is no code change.  The
previous posting went out unthreaded (patch 2 was not a reply to patch 1),
so this posting is sent as one threaded series: cover -> patch 1 ->
patch 2.

Changes since repost1:
- re-threaded as a single series (no code change).

Jamal Hadi Salim (2):
  net/sched: sch_teql: fix shared headroom and header strip on slave
    retry
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  1 +
 net/sched/sch_teql.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0
