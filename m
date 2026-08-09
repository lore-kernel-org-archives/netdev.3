Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD353C1D5E
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268667; cv=none; b=g/yQf8JgNock06QpNEu5xaancrlo9jR+Dv6zNTvivwvSo5FkZCokzDs/eToFQiva+In9WrqG/VHJ0spl5WiR+6Y0w5cX1OwSTqQg0vjQbLtGhhAHjH3pabIOqaSZveDhz9c3BR1FuBWV/IEK7D1FdFaDcjoKiRbCYWMjcnNAZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268667; c=relaxed/simple;
	bh=SBy8UkRKctCDpRvFyKNpIEJEDseOmXowQnJx3VRnZ/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qj5Fws4vswfWiqdjgy8tq+AvfJRBlza3aqjTFk3bHVg9wF4VA0S4rwjAQCNF6Llzns3ftstoD831y0dVC5XNnaCyTNLF1cT32FGXCiC3cD0pLerJD2veSSpDo3zOJBpW1fv2PDg6s1XEsWX5bGZ5QqChaw1a2gqBDZXexykAGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gXikEJ5m; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gXikEJ5m"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90898faf46dso4103756d6.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 02:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786268664; x=1786873464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D/fZZWAgqH7e6IlWLoCPEJBVVdiMilFjTa0nxCpwM+k=;
        b=gXikEJ5me7Cw7KqUZYMHskGuoOx44qllTEG0PqvPReF41DvBkQ8n50BUm+BfJGf4HZ
         OeY+B/E3NWao6CMpvl561ZD3nm0hgh3Wx8Qr70WJEH15tSTj3kyP8gknGZvw/b/u1PX2
         fMjYPujKYu/+XGJyymhIZrk/lQsSeL3hFbs2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786268664; x=1786873464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/fZZWAgqH7e6IlWLoCPEJBVVdiMilFjTa0nxCpwM+k=;
        b=rc6QrelG99U7GgA774sKzIp6BD9aVVqw4Lx1qvJlr+SSQr1/97RrxuAOMap21xfYKN
         YhL+jm2I7adUxp+NhHdTisFzqY7y0jYg+gZZ8KwO/+61nNE6zMhpM8A426ViSB5IqzbQ
         /d3VhUblTCcP4qTK//sVCDyU9HB5oQOtlM+7pMExjEmFzbXhFylmiznDwhCvT8oQoX7C
         AAZB/ryObYwMhdG8jOrz41icEM0QTZ8WPkwX6wXMIiyJdmVWzHi/XDG6Y9GLS8IAjmpY
         iI9SHTEcQ3IeRctqDxHj3i1r0uFVMzfieO0xtfsME6gwNKXbuo2oCNohDohsuQLGwrgo
         x0Yg==
X-Gm-Message-State: AOJu0YzIA0VweRbrAcfhmX3nFnnR7gLvb6UKzkK34CEsNwuq6zN1TOH9
	UyNE1Pv3ZPKghveJ7ki1BUcJGjzYYaog2kNTVNDmNB8aCYE7AMJ7q+OEeYbxc+836F+jg2chs4r
	ntCY=
X-Gm-Gg: AR+sD10zgc+K7a/6vjX5yAUXNNguQLa5eeDfOgP/cWUTu2U33UvVHcDoD5628u6dNqX
	Qf3ybnsgiEnXzyyHj3sZSExO5QwZO07CWxxy9rIKN+Ycb8jED0++2WeCAmUk0vV1ZNzAE5nfQBh
	NjtbOaVgeCp/pBcBHAQT5OQRunJGfgodk4ACKhc1K8+4cFlr0gLykX479OvOcRY+jBUDxvV2u56
	xPIrRsuEMPr0rR/AeNZnSIaW8gA2i2fYy2cBqXJMq7Hw+1CeFf8y7TdMhgCX+p5CsqGYGvwefo7
	N0ou268v9CZUYkpUiwSEvUAvYoZGk4UNbKc1Xrk3focsT6kzPBOYUs6APCWwhaEh/+GokQpx5hj
	vcsfo5jjmApR2rVjCCHESusCcvxeW29HHICi06zJl0COPTs1NDPwxLt/iMdNulXVOXCb1iS7tZT
	kLOoWUR173eXITUwSLEY6r9zO6V2WXcVreJsSLvN45Cr+5LI76CvLO6eodv7SDr3zk+Zy9fNkis
	DC0dKvenOwJUdBj3KnaaRnR2UXKXUkOkwlF3IAfbjE/iL4=
X-Received: by 2002:a05:6214:5789:b0:907:5451:8954 with SMTP id 6a1803df08f44-908a70876f9mr182514366d6.16.1786268664235;
        Sun, 09 Aug 2026 02:44:24 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a92ff8c6sm47361106d6.28.2026.08.09.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:44:23 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org
Subject: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound to a different device
Date: Sun,  9 Aug 2026 05:44:18 -0400
Message-Id: <20260809094418.901607-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
bpf_prog_get_type_dev() but never verified that a device-bound (offloaded)
program's bound netdev matches the TC netdev the classifier is being
attached to. This let a program loaded with prog_ifindex for device A be
attached via cls_bpf + skip_sw to device B; deleting device A then
destroyed the program's offload state while it was still attached to
device B, triggering a netdevsim WARN (panic with panic_on_warn=1).

Mirror the XDP attach path (net/core/dev.c) and reject the attach with
-EINVAL when a dev-bound program's bound device does not match the
target device.

Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for specific device")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_bpf.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 001d8c4ebfed..6d19155becc8 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -374,7 +374,8 @@ static int cls_bpf_prog_from_ops(struct nlattr **tb, struct cls_bpf_prog *prog)
 }
 
 static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
-				 u32 gen_flags, const struct tcf_proto *tp)
+				 u32 gen_flags, const struct tcf_proto *tp,
+				 struct netlink_ext_ack *extack)
 {
 	struct bpf_prog *fp;
 	char *name = NULL;
@@ -388,6 +389,19 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	if (IS_ERR(fp))
 		return PTR_ERR(fp);
 
+	if (bpf_prog_is_dev_bound(fp->aux)) {
+		struct tcf_block *block = tp->chain->block;
+		struct net_device *dev;
+
+		dev = block->q ? qdisc_dev(block->q) : NULL;
+		if (!dev || !bpf_offload_dev_match(fp, dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "Program is bound to a different device");
+			bpf_prog_put(fp);
+			return -EINVAL;
+		}
+	}
+
 	if (tb[TCA_BPF_NAME]) {
 		name = nla_memdup(tb[TCA_BPF_NAME], GFP_KERNEL);
 		if (!name) {
@@ -492,7 +506,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	prog->gen_flags = gen_flags;
 
 	ret = is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
-		cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
+		cls_bpf_prog_from_efd(tb, prog, gen_flags, tp, extack);
 	if (ret < 0)
 		goto errout_idr;
 
-- 
2.34.1

