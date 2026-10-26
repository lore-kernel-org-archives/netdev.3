Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792987035;
	b=WpPU0QqRJqcd9llw8b6+r1XS5XfQoe2z0Yjzv3C6q0+Xu+LLM2w9ImfHh2cOm5XlVJoa
	 CQZtKlkElds8CpZ9t/7aHE6vVPRYpFKhYCfP35nkmDcByHtCswVE3dMiRu0UEoqYO7Ejw
	 A1kkdSiuyUJ9jFyi/nURRo6b6Oh0sgI09+s/Im/a4q9lNHds1mKTIR2nMCudMrB8vNgLD
	 MAKl1H7Nju4777HARgtdXrELaeU7FnsThCGWLsGIye18Xe+w+7Keb/sig6hEFT8R/Wd3a
	 4J7gj20yHWP1XjaC/2H6wwutp8zqXgLqdeep797Q+SkLuI4+sPXKwHaRmtNAjTYDJxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792987035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+ScCUUWyJM//qpTpz7tt0Fdxp9XvYrNhMa0jbjZM+Ng=;
	b=K6yx027O44JRBlNp28TMQHCcenR+hoFflksCtzNdwNskBD7+NLY7ldlLNP6K964nRSIP
	 J91emMmRTQsflOLSTSQesD+XtZf0gyKgwzPl1++HwQdk75DxrcqVN1oTdwEnFBpu3ekgZ
	 hSLP7+28rLfbzXafECErnpocgQd+gFsGQ6JNwd3EeWxrSQvi0GiMiybhyVdYU0A+ogV9L
	 a98krUJAkUHAhC/+IOIFaMgQxE9WNnOhHMfIfSjhFEChDT2PX2PMd/icQcc8+dMDOnIPk
	 cs6vVuTmbfKG9+pxtkyzUE+TDTfBsArQvQr1mdD8669Z/PMpo30amMg1+Z2gM36PIZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C8606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923C8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35b2c599f43so467828eec.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792987029; x=1793591829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ScCUUWyJM//qpTpz7tt0Fdxp9XvYrNhMa0jbjZM+Ng=;
        b=CzHL8JAAhVXZp+BFIea6XXS5CXvIdKyvTb9rotyb9xP51zqNOdUyULSyK62QT2G7qO
         7v7qzFb4ekjP8THGtkchX7EdobigL2eBQbw+WhyrhbXrSIQnzUg+mhL33OKcdQw/kCOl
         zq1zDO6mrkZUzmX7FZqHcqcNncLTFdoz8LPdi0HLuB1F1rfz8enfQHRYXYoq422/oXFK
         mPtlgYSvIeU9kcWQBdlA3APCubO0DXLc4kb8YveBwZWFD9FPg86N0L1cKM2rfH9DDam2
         E2jObCINjT2AdecrPCYLiQbyEsbP7oepRFvC9D5xQPmCjEWHmKY3xEsXTQ/XabPJaAj2
         pxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792987029; x=1793591829;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ScCUUWyJM//qpTpz7tt0Fdxp9XvYrNhMa0jbjZM+Ng=;
        b=gE18UnBmulArrZOIillSv0zJXDdT9suSGqI5sIIVYk/KLvdl2t74PPnPRauj2Er571
         /h89z2LEmKV8ksXSgaxm2kU9LWaXf1TubEWo+0nIV7xSAxxw9XJK7yuH7PuRPHNPT8vs
         zTIq972AGSTmi6Vw903SfaDcN2kDhG1FRYmoZCG7b03kfqlBmXycOFV1IVv752m00wit
         dB+axd2J/yz14EFKjGNlT5AI0M4hVQMQcT3mz3PvgkBVETm1uhwN1SGXwt83K4dLzF7K
         sMJ6YJkTriUEs0UshHUu8WfH5Dkn7f0xGnXMXWVO1UoOt6iRO5CJJstX8zlH26Gew+6b
         Nw8A==
X-Forwarded-Encrypted: i=1; AKwUvBzRq/EPKcltG9jtR9YfJWd1b2gnww30KK/RiJdVi/neJ6lDNmdNOzjnBlSKOZj+jRmAZ+mVTJo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG7YG22fCWOFDndXV8Y3u6vlXUsmukbkir68NmPiV0DGQlXNhs
	WZPGkHw7SGHV8/GsqaF4Vv7r5uyrSjYWJIP92jiVHM/jNIOuxkP4J/ei
X-Gm-Gg: AYBFou2fuDViWti029Ymmh4BQRuN+OVs+mK5pkuQl9W5Q6L0mDA+2sjj9r/G17RN2vK
	E5mjrkj/ntr6EsXKNU1bO+l8AqvFMt92O+OovtO23pBUv+ZJPIh+kpP4e9w1kqqxn/bFvh+VTcW
	D+OuqJ7wdLFYb0TskanrcqmfDBCpY7P0F2jl6CNtXkdQp4fH1ekLyE0d16vm2uB+FjjBAHVx61b
	ZdL/K23ZvVjCHES/PdNqKncY4cO4f7WeRZxciVd0o+5yKj/hFzaDqZU/P7CtXzqfZidhv4Xku3T
	Pw1+P+1dT+hUXqkuULDE/j63hz77ioPAo8l2XebImDH1uTUtbwUf/5hTvlsUCDdcpVVapym8yH8
	Aene/QHXVCFfFWGk+0N6vlBhyjD3T5aUw8e1NydbIFhPlBz9Zjxfgcwr5IIj9DkZiqitBALHyh7
	2keqWQEXszbPTtxwJyetXmok1h+S1xYgQe6nqDlaXAsOm4XgUc4MzgFryLmjKp0NOtyloPCNlY5
	ViQhFw633X7ar4+nUCi0z92T5MlRvxCz22Hn6nm3SgasneGfua8Wz2fsCoEyviL7lrvRVORZdG/
	THMCz9VUeDmnwFllAE9SRrQvIRr0F3l0TN/yf4Uc1FMqkqInH4OybDvFvrxwVbbm/Jgk1Ry0
X-Received: by 2002:a05:7300:f0ce:b0:366:846a:e21d with SMTP id 5a478bee46e88-369e84d35c0mr9182619eec.33.1792987028486;
        Sun, 25 Oct 2026 20:57:08 -0700 (PDT)
Received: from MacBookPro.lan (113x35x113x191.ap113.ftth.ucom.ne.jp. [113.35.113.191])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm24441240eec.13.2026.10.25.20.57.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 20:57:08 -0700 (PDT)
From: =?UTF-8?q?Paul-Louis=20Charri=C3=A8re?= <plcharriere@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Jalen <jalen.lin@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	regressions@lists.linux.dev,
	=?UTF-8?q?Paul-Louis=20Charri=C3=A8re?= <plcharriere@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: remove hardware flows before unbinding
Date: Mon, 26 Oct 2026 12:56:51 +0900
Message-ID: <20261026035651.40052-1-plcharriere@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAHqkChbVoGHrWtaFyGFaLQDiAunWw1qOpW-vKSgkKxWEfQ_tCg@mail.gmail.com>
References: <CAHqkChbVoGHrWtaFyGFaLQDiAunWw1qOpW-vKSgkKxWEfQ_tCg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 13210fc63f35 ("netfilter: nf_tables: imbalance in flowtable
binding"), FLOW_BLOCK_UNBIND is called when the flowtable hooks are
unregistered, in the commit phase, and nf_flow_table_free() only tears
the flows down later.  Their FLOW_CLS_DESTROY requests then find no
block callback, so the rules stay in hardware: the flows keep being
forwarded, and drivers such as mtk_eth_soc and mlx5 keep their entries
and reject a later flow with the same cookie with -EEXIST.
Commit 5acab91458ce ("netfilter: nf_tables: unbind callbacks from
flowtable destroy path") had placed the unbind after nf_flow_table_free()
for this reason.

Remove the flows of the device from the hardware in
nf_flow_table_offload_setup() before unbinding it, as
nf_flow_table_indr_cleanup() does for indirect blocks.  The GC run that
nf_flow_table_gc_cleanup() waits for may skip flows with pending offload
work, or have started before the teardown, so queue the GC work once
more, wait for it and flush the delete work again.  A direct
nf_flow_table_gc_run() would race with the GC worker.  No BIND or
UNBIND call is added.

Found on a router with mtk_eth_soc flow offloading, where each firewall
reload left the flows of the old flowtable bound in the PPE.  Jalen
reproduced it on mainline with mtk_eth_soc and mlx5 and tested this
change on both, see the report.  Build-tested with W=1 and sparse on
arm64 and x86_64.  In an arm64 guest with lockdep and KASAN, with TCP
flows through an offload flowtable on netdevsim ports, the delete work
of a deleted flowtable now runs before FLOW_BLOCK_UNBIND returns instead
of after it, and nft_offload.sh passes.

Fixes: 13210fc63f35 ("netfilter: nf_tables: imbalance in flowtable binding")
Reported-by: Jalen <jalen.lin@gmail.com>
Closes: https://lore.kernel.org/netfilter-devel/CAHqkChbVoGHrWtaFyGFaLQDiAunWw1qOpW-vKSgkKxWEfQ_tCg@mail.gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Paul-Louis Charrière <plcharriere@gmail.com>
---
 net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 4365859220e..3844a23af5b 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1279,6 +1279,19 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	if (!nf_flowtable_hw_offload(flowtable))
 		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
 
+	/* Hardware rules are deleted through the block callbacks, so delete
+	 * the rules of this device's flows before unbinding it.  Run the GC
+	 * twice: the first run may skip flows with pending offload work, or
+	 * have started before the teardown.
+	 */
+	if (cmd == FLOW_BLOCK_UNBIND) {
+		nf_flow_table_gc_cleanup(flowtable, dev);
+		mod_delayed_work(system_power_efficient_wq,
+				 &flowtable->gc_work, 0);
+		flush_delayed_work(&flowtable->gc_work);
+		flush_workqueue(nf_flow_offload_del_wq);
+	}
+
 	if (dev->netdev_ops->ndo_setup_tc)
 		err = nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
 						&extack);

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.39.5

