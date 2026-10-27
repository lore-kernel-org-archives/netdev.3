Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087814;
	b=RUZS7yq6Xf5RgOuD1QJqFNd4cahIJ77LEhofK2V+x/ns1lcRRKP+rz1qReoX+CInp7qV
	 9fNT3ilr4jO0th6r7XYLjuJCIst1M4foD71PHhVWU8EVnE4rH5hnJWCbJtmXeCkbGZzMe
	 62ozTYdbSv6D/qOCTmam2qYhlk2IMAdwWWQekl5aU1gmO0NzD+K8YXI0xorjdBTudv4tc
	 1zyMS/z5nNYMG4ogf7t8Rr/1vdEhGu1HuOj8PKlynS58tKP7FDl//IFByKJQJxQOQ/6BS
	 tNg2dNZi2YKp+a02ew0KcANxgc/kU1uM7Quqn75qq6ZfYidiY08d8kEGeZhtNJWwNIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1A1q98MDq9vsGC0QU9m9r9Mp0Eo1mNt5bymoPMbu+28=;
	b=XPA3/Q6os7942rm0iw6sLrq5faYq+LKS6TMa1FmfhfhEtMXer76a44RurO8Z3HoEIr44
	 EuTlFrRVHVaPyM7L39atVW6xCzXYZLL/OfXqtn91Nad9ewWAQET9CIn4lYCZhUq2MO77Y
	 ovnlAYLD1zb6eb6an1H36Dy4Tftej0fpWho6zxp+pK+O1dZCZaDTRjFh8kmW+phCQOHlr
	 qA+GEXD8+V2WbCbdFzkWV+Tsxqd4U4iR9iCNfJZlcwQU03ANRLuyJeK9de1Uy/PTaDo3Z
	 ua1M5DbMzlSa/dVK5UK1E/NtyXMHeRgnfBGfNDrvZIi1mDlz7U+mFZPAKaKcSwGZwzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=kbAktSy4;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B5606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 463B5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=kbAktSy4
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93cc1ab5f6cso410227085a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793087812; x=1793692612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1A1q98MDq9vsGC0QU9m9r9Mp0Eo1mNt5bymoPMbu+28=;
        b=kbAktSy4Y4Ph0Zz/D3olPPlFSxivFRApKf0kf2j6SoZFtbI4KELhjoUtozjkB+Kxbt
         3Xqlf2QmdyOYYnCvIcd4EmSNjsW8oOrocOgc15LG7/tQn7ZrGzR7zwL8WQjUtpiY60ts
         EPZdSjMl2oJ/3UbppCs52d3cK4GyPq++1r1rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087812; x=1793692612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1A1q98MDq9vsGC0QU9m9r9Mp0Eo1mNt5bymoPMbu+28=;
        b=HVA71lZcLlQoE3XZrd4iuZOptrfZ0ir3QpOxJ1j4OUkB/NnlLi0wYO4l84E2D+eQk4
         1w9q1WCqK6FZ3B4ktcNbD6DatCr9PXUXGeYybAwgHodBrE9hIapF6P/zl3sHx4+I4kOq
         93sv3T0OAUpcrO5K23Dc2FkrL8nuGX77iBMqVjO9cWUbWi9qYJvOIZQLZ7rm6yTV4tgx
         2+88By+6mHR/wJgCVe4w0P2TDOBUtlApva6PDkZpquaUPB2UQ6XLOmjBXOg67hcHb3ba
         Cbz1O0qcz/N6ZY3w75qDorF+SSq9/agHZrg3DWFQ7k8R6DgD7HtD4yt5sOeV7D4VyksR
         2QRg==
X-Gm-Message-State: AFq9FYJldsmYYk2PigqI22lWEnqqhWYc5E4MoSnJ9cBsP7zc5B0jSc6z
	VhdysoEnqT9cAx1warGcivHz6dEmZmKEVXB9to0WgFity9rPDZzTMVMlVmeSOxyJrd69fLa5mlP
	EXw8=
X-Gm-Gg: AYBFou0Vh0+jq/dd9VUmvCjSByNmXcs4NAtPb7EWZ+yMDV73F/HLWAof6tFQV/XYJsO
	dzgwtEMwHvDpvu7OrnUd0MHaPXJKyoh+IrSGDuUKLCgYeIasqLaJySeogNIxPc7DM0HQy4yvxdN
	891uHx1ldj4n4ut1hfHnCfOuSseMpSLlp+QNOmhWeItsX2p4cgDZZXxd/pyKe35K71AvyxqfKkW
	nq0z0KZwq9reZ2lYSNV8++Us4muLKPNDVCykrmoNPWEYmdJdGIiS7nwroEJhp0ZZin16izSqJgQ
	gOwbYmWLCna09A3YIKNberLzNh175FKEyLOND2HqDlkeK0SNUlkgmkfaxZvNfBbg0Nd3FCYsQVu
	fGCofKAQVPbg2l1xMUrpflEibrllHneqrr+UpimHQ9pNKFq0gTPOpBdvoO7GtjTouaW2rCaky8f
	gc0xCxqt4yh/h5K2D5t7/6h24w4ormOZfRabZ8+dAOOF7HDVWUR8lAZ9sgN0ypP8VIRza+/LrKA
	DB3bED6l/zfjJZJUtrnbLUW33IwS0QKW536FTSnLwMP44JccanULdCmx/DnVqxvYd+lMCc032z5
	/PXeyGEUPY1847gyrRcFaY7fgj7lqty+9irPLMHSfA==
X-Received: by 2002:a05:620a:4151:b0:93f:2ab9:72a0 with SMTP id af79cd13be357-940ef94cab0mr1365449285a.70.1793087812145;
        Tue, 27 Oct 2026 00:56:52 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066629dsm906675585a.7.2026.10.27.00.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:56:51 -0700 (PDT)
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
Subject: [PATCH net 0/2 repost3] net/sched: sch_teql: fix header-cloned write and retry strip
Date: Tue, 27 Oct 2026 03:56:41 -0400
Message-Id: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com>
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
header write corrupt a header-cloned skb and strips a userspace-supplied
link header on retry; the second leaves skb->dev pointing at the teql
master while the skb is parked on a slave's neighbour arp_queue.

Patch 1 makes the header private before the write and pulls back only
the header the slave added.
Patch 2 moves skb->dev = slave ahead of teql_resolve() and restores
skb->dev at the arp-queue reinjection point, so a parked skb names the
device whose neighbour took it and is delivered with a link header.

Both are follow-ups to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path").

The pre-existing teql issues reported alongside this series are fixed
separately, not here.  In particular, the lower-qdisc drop use-after-free
(`NETDEV_TX_OK` vs `dev_xmit_complete()`) is fixed by:
https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

This is repost3 of the same two patches; there is no code change.  The
only changes since repost2 are the commit messages: the patch 1/2
message now says "header-cloned" instead of "shared", and the patch 2/2
commit message now describes the reinjection behaviour change for
bpf_redirect_neigh() and nft fwd ... neigh instead of claiming the
restore is an identity for every parker.

Jamal Hadi Salim (2):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  1 +
 net/sched/sch_teql.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0
