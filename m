Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538149;
	b=g5wA6HSlZifkh4ndrA6HcS1zHHREsM51z6anzGRMWP3+i3mmKiixrK9JLarkXaEDtQ16
	 llvJDnJWOXiiyYoJ9TolnmWbjDzFFP8dEGdS2GVvgQA1YN3XQ/KfNYuQG9FoQDuTTEZbG
	 7Ra0OFqK5sYyArGshXMBo63QwPpEwY5PMqb0AqjYsHBtS+8zK1OEo1r0XZKYIAkK3IhBx
	 1k7+bSDVirTRhtJ3wOehp99oL3nj0G3IHq6Glhfp9DnUgrXGJHP96GuvrKvf293BlGscF
	 pBzn2OR5TCjpjYESDfPZIhBQ8Y8GSawwp9KjIB/G+4mrit4u82v0QLqq0VAnrwyZnXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538149;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=IpFP7FK0TxXG+9D2GX4+uqXkz9xTOzg3xtyPrJM7tPk=;
	b=4K0zV4b/br7fZD+Zlpdewb4cPvbdQONtT9d/SvAtCovgPQK3T/gWWVlVVqWSlQXfuRK7
	 w3lQ+aT01ubFHBcx/Eafrc1cXU7UAZ3o03haKXmoS/x0jXJ5Yj0D381/BywIrP4QWusMb
	 zBgdauaP6l28WRGceqLCz0lT+tvLTuaHA50v0XmwGypti6yLG8V7XGfYtm5wAYPhb0xKV
	 hY8+b+XuYRP0bZV4tlH/8kz/PmQ7pl1oX5MbS+o6lMKatvVVkEedKXkuYwAbE1maPXKDd
	 yHKbgFZcwGouMsEVOKONAabaVpCHP58wjxjkGYjG3pYbCMY8Ta8i2A2dffcfmLr6faw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q3phdKHM;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FCD606A321;
	Fri, 13 Nov 2026 02:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85FCD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q3phdKHM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ip
	FP7FK0TxXG+9D2GX4+uqXkz9xTOzg3xtyPrJM7tPk=; b=Q3phdKHMGYJCycRqw7
	WMNzyZM2lnm2wJTYUzhdtmnrB55pcclTiMdL1AXodvkRQGaY/IRI3pqqhv8d3p9M
	8RCMy4wHunz94dUWFzp+7t31H9PP2W9+d31hNOtED+xfVyeI5NKthIciMhFGngAs
	LmqYbQGXJaYIo+v+HiYOas360=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3VxpzevZqetpIHQ--.11346S2;
	Fri, 13 Nov 2026 10:48:20 +0800 (CST)
From: Wei Tao <taowei@kylinos.cn>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Tao <taowei@kylinos.cn>
Subject: [PATCH net-next v3] net/sched: cls_flow: avoid integer overflow in perturb_period
Date: Fri, 13 Nov 2026 10:48:02 +0800
Message-Id: <20261113024802.71680-1-taowei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3VxpzevZqetpIHQ--.11346S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr17JF4rJFykXrW8AF17Awb_yoWrAw15pF
	Z8Aayqkw4DXF1xGw4kCF1kWa43Ww1rJFWfCF47C3y3AasrGr1kKa12grySkrn7CrW8J3yI
	qF1YgwsxJF4qyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8jjgUUUUU=
Sender: cs_taowei@163.com
X-CM-SenderInfo: xfvb3tprzhxqqrwthudrp/xtbC4hUUVWr2enVCyQAA3u

flow_change() calculates perturb_period by directly multiplying
nla_get_u32(tb[TCA_FLOW_PERTURB]) by HZ, without any overflow
protection. Since perturb_period is a u32, the multiplication
overflows when the value from netlink exceeds UINT_MAX / HZ.
The result can be an unexpectedly short period or even zero.

  # tc qdisc add dev lo clsact
  # tc filter add dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 42949673 baseclass 1:10

With HZ=100, 42949673*100=4294967300, but UINT_MAX is 4294967295,
so the product wraps to 4 jiffies.

Both the filter-modify and filter-create paths in flow_change()
are affected.

Since perturb_period is ultimately fed to mod_timer(), and
calc_wheel_index() internally casts delta to signed long for
comparison, values greater than INT_MAX / HZ must be rejected. This
keeps the relative timeout within the signed-long range on 32-bit
systems in addition to preventing the u32 multiplication from
wrapping.

Declare the limit in flow_policy with NLA_POLICY_FULL_RANGE(), so the
netlink parser validates the attribute instead of open-coding the
check in both paths, and pass extack to nla_parse_nested_deprecated()
so userspace is told which attribute is out of range.

The missing check was noticed while reviewing commit 7ca52541c05c
("net_sched: sch_sfq: reject invalid perturb period"). An
LLM-assisted analysis of the same pattern then showed that cls_flow
performs the same unchecked seconds-to-jiffies conversion in both
its create and change paths, and needs the same range check.

Tested on 7.4.0-rc1+ (aarch64, CONFIG_HZ=100):

  # tc qdisc add dev lo clsact
  # tc filter add dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 42949673 baseclass 1:10
  RTNETLINK answers: Numerical result out of range

  # tc filter add dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 100 baseclass 1:10
  # tc filter show dev lo ingress | cut -d' ' -f9-
  handle 0x1 hash keys src baseclass 1:10 perturb 100sec

  # tc filter change dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 42949673 baseclass 1:10
  RTNETLINK answers: Numerical result out of range
  # tc filter show dev lo ingress | cut -d' ' -f9-
  handle 0x1 hash keys src baseclass 1:10 perturb 100sec

Signed-off-by: Wei Tao <taowei@kylinos.cn>
---
v3:
  - declare the limit in flow_policy with NLA_POLICY_FULL_RANGE() and pass
    extack to nla_parse_nested_deprecated(), as suggested in review
  - update the tested transcript for the policy-based rejection
v2: https://lore.kernel.org/netdev/20261106063823.99731-1-taowei@kylinos.cn/
  - drop the Fixes and Cc: stable tags: this is hardening
  - describe how the issue was found and add the tested commands
v1: https://lore.kernel.org/netdev/20261016040330.59041-1-taowei@kylinos.cn/
 net/sched/cls_flow.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 2ef449706638..2e1825f09ea1 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -357,6 +357,10 @@ static void flow_perturbation(struct timer_list *t)
 		mod_timer(&f->perturb_timer, jiffies + f->perturb_period);
 }
 
+static const struct netlink_range_validation flow_perturb_range = {
+	.max = INT_MAX / HZ,
+};
+
 static const struct nla_policy flow_policy[TCA_FLOW_MAX + 1] = {
 	[TCA_FLOW_KEYS]		= { .type = NLA_U32 },
 	[TCA_FLOW_MODE]		= { .type = NLA_U32 },
@@ -370,7 +374,8 @@ static const struct nla_policy flow_policy[TCA_FLOW_MAX + 1] = {
 	[TCA_FLOW_ACT]		= { .type = NLA_NESTED },
 	[TCA_FLOW_POLICE]	= { .type = NLA_NESTED },
 	[TCA_FLOW_EMATCHES]	= { .type = NLA_NESTED },
-	[TCA_FLOW_PERTURB]	= { .type = NLA_U32 },
+	[TCA_FLOW_PERTURB]	= NLA_POLICY_FULL_RANGE(NLA_U32,
+							&flow_perturb_range),
 };
 
 static void __flow_destroy_filter(struct flow_filter *f)
@@ -413,7 +418,7 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		return -EINVAL;
 
 	err = nla_parse_nested_deprecated(tb, TCA_FLOW_MAX, opt, flow_policy,
-					  NULL);
+					  extack);
 	if (err < 0)
 		return err;
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.25.1

