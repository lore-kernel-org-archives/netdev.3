Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135635;
	b=yFpyur7LdZYTP+xV6egCeE1m5l2swca9AtCeZS5WNhRZkW1Al1JMZADAizmPhrGWqe5s
	 9kf0cDsAO/UiZKmYnTYaqOyg4MIzRv3v72P7FSl7CmxgJD+gSMj8h1UaR6uO9gCd2Q7Rb
	 HVOF6pPiJozuUbKHmzvgjxSazQcwJJwGJ9HyLPeZsBzFF1wdzV3naXAazdjJa2T1u8grp
	 FOK1NjUsUMTG+y+WRb/HXdaI0lMX1Uj3pxT19FClAgsqfzOLA+QEtabehdD29kC2bpT7p
	 uPGxcvN42GD0yNTlx56KYtGHpF3qgBuENLqut6u/2zvTYn8FNBqcymLmoD3tgLt6bLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135635;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Ttz1b1xvGOZQ5uY4SvW+d2KsWCJGIzO1EwdoPlIKTCA=;
	b=ki1uOYlffsrH0vJ14tu7DotoE4XMU+llaC+Tp/y5zEluhc3FZCX0p9Bm2fiTkh1N+NjD
	 8/bX6IRHOcbUIDXuSK8tqyVgsb4j/cOrJYqDCMRt43gk/84NIoDJlEZF8x/3MRD+Sxsu2
	 ohkqwjY6ENnd1mHu3HLCY2RCGjQYxzdnweXKVhVB7JHC91YUR7sEiEOYaP75SwQqa6Mpl
	 0L+xsX7KOpgoa5kgBOauGDeH2JZkM0vnO0sCC4aZhW/jYTPpGTDml7Fe+h05ovFsG8RRL
	 u0oT7JfllxMnJa7v4tj2OD1NTDoerOaWsV7y4xHW48zcoBvytATwhDU0QV1PVfu0cwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD83606A321;
	Sun,  8 Nov 2026 11:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD83606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABH4LVIVvBqgvOZAA--.18736S2;
	Sun, 08 Nov 2026 19:00:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, vulab@iscas.ac.cn
Subject:
 [PATCH v2] net: mscc: ocelot: release the mirror reference on policer failure
Date: Sun, 08 Nov 2026 11:01:38 +0000
Message-ID: <20261108110138.315003-1-vulab@iscas.ac.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowABH4LVIVvBqgvOZAA--.18736S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWxCw47AFWftFykWFyrXrb_yoW8tF4kpF
	4UKa9rGr4qqF4fuw17Zr4vv3s0yFW7KFZ09ry8uws3uwn8Jr98GFsrtFWj9ryDCFWFyr92
	vF4qyw4UA3WDAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQFA2rv4kizpAABsi

ocelot_vcap_filter_add_aux_resources() takes a reference on the mirror
before setting up the policer. If ocelot_vcap_policer_add() fails, the
function returns without dropping that reference. The filter is not
added to the block, so the deletion path never releases it.

Release the mirror reference on this error path. Use a goto-based
unwind ladder so that a failure added to this function later does not
have to repeat the cleanup.

The issue was found by a static analysis tool; the candidate was then
audited and the fix was prepared with the help of DeepSeek and
GPT-6.1 Sol. It was identified by code inspection only and was not
triggered; this patch was compile-tested, not tested on hardware.

Fixes: f2a0e216bee5 ("net: mscc: ocelot: offload per-flow mirroring using tc-mirred and VCAP IS2")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Sorry for the very late follow-up to the review.
- Use a goto-based unwind ladder, as suggested by Simon Horman,
  instead of an inline ocelot_mirror_put() call.
- Describe how the issue was found and how it was tested, as
  requested by netdev-bot.
- Drop Cc: stable@vger.kernel.org: the leak is only reachable when
  the policer allocation fails.

 drivers/net/ethernet/mscc/ocelot_vcap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
index 25e533e91d71..ce4a3da38c58 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.c
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
@@ -957,7 +957,7 @@ ocelot_vcap_filter_add_aux_resources(struct ocelot *ocelot,
 				     struct ocelot_vcap_filter *filter,
 				     struct netlink_ext_ack *extack)
 {
-	struct ocelot_mirror *m;
+	struct ocelot_mirror *m = NULL;
 	int ret;
 
 	if (filter->block_id == VCAP_IS2 && filter->action.mirror_ena) {
@@ -971,10 +971,15 @@ ocelot_vcap_filter_add_aux_resources(struct ocelot *ocelot,
 		ret = ocelot_vcap_policer_add(ocelot, filter->action.pol_ix,
 					      &filter->action.pol);
 		if (ret)
-			return ret;
+			goto err_mirror_put;
 	}
 
 	return 0;
+
+err_mirror_put:
+	if (m)
+		ocelot_mirror_put(ocelot);
+	return ret;
 }
 
 static void
-- 
2.34.1

