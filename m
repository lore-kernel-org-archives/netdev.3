Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4849483D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058964; cv=none; b=AkFnbSb0afD/1aQCc8P0N9sNoh5ceXplDeb6P4+VgUZ1i7zsaQBIRPEtfU9d3Qbg4JP0+UYzlkSJ02fyyGtO67WvwjJL19OdAwC8TtqK2lTCRuMSsU548GlcaSuXU4XBw4lF/IPnhUjEMLWhdQc7d3CMv//UHeIcy69hoZ2gAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058964; c=relaxed/simple;
	bh=A9XgX8W2pWCUw5oU0LmaoH/4TaNKClJ8Kva/tAp75qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASAU+m3km0pfRWhskwY35vtK0GFN7hDNINXVQNEsI0k1kTKt7dy682m51mbZroKMJWPek4NF5z4B9Bofm2TNtu2irtedrXADEkSmtkPpf1IkqROd7RIoCCg5Nd8qzgjKR/+1MYo/Q33jqNYrcueX2ihkxTytE90z/uLCGYIAcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7kpub8r; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7kpub8r"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6682259cae6so3089280d50.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786058961; x=1786663761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lhh70WyOc/d5qzjw6H29xHEqh1T/3dX0IfBg7BkrsEA=;
        b=g7kpub8rhgRwANSvwlDoZTRLvReU2rC5zl8E1JK3PcegT7YxzV2LJjwkWkJaqAqhnt
         13A3xw0xZMNrPARUQ5EIXgrjN1OSGk5pSPgUxnmXl2PY9wuApbZRp8q02myEeqEY9WGx
         bO+yssFr4OGag8/q8mkvz7tUDdHMoCq/xMrElHxei/4kOOqFai05f6JzZ/vVvhZwY+qu
         JWI1TM2JWmIrtaMD1DYWeoF+YoWaDInRiMvvgQNzd+UZWL9x3XAYZ2MCXoG6pnzjAh+/
         010z4OKxvoqqywLS4f88IZ4ppOHBMAxfpKG6RQswRmEZMZXAKtDS5DQUT0BqhIATNWlK
         TwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786058961; x=1786663761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lhh70WyOc/d5qzjw6H29xHEqh1T/3dX0IfBg7BkrsEA=;
        b=m+0QhGTGmb2q7Jg9n9Z2Qxhz1I+TH3o6JDtIZAP/oiM/5PY6MO/SxjiO8E2eOGovt8
         l//+57OuBnAgtPTlVmg6BoRAwluZnZP1/lf3sR1oCSJ9Bmsen1S/OkQuFT2CwylgbHUZ
         jJRkAL/UQnzWOJBvlHBVFxj/j+zXe9Wzvbl1fYQMVpmAQCg1j7k7xRfvGymJ4T5QfcUD
         4kwqahrmSxIhP/j4DzhKIB9K8srqG9jeCGVD8lTQoZz3sZ9AwLDBZSJDIIyhBzi6C66T
         sUk9c+umjqgVC51Ffi94/XKvyWXCoBDgGVfy4XT/TmyJ3qhHKUy0bHvu+7y+/2dIeFfv
         QJWQ==
X-Gm-Message-State: AOJu0YwXCEt2582KPalSmv1we0p/V1jSaNM9ezrpBKhUtrmS4YemBSPs
	jYv4QYfHO4TRANEinCzVr4oTCRJyjm5Yp/PXLTNRM08OF27RPO98mIr+tNP/JA==
X-Gm-Gg: AR+sD12JkvM29gLTmtRaQQldp+87YXNVLLYgsfCitgTLD/H+TZUA34fdIntazftB3a7
	dRFDapC0bQo2GXzsNjLwSjCxj1PA7PWfCGot1hekGfLTJSLKWMhVhphRNZtJcdViC2JORbAdmkC
	/rohnD7o3S/AEi1YlzD3N0ndothKYiRrQ5QWMVx5H9Q1XfmwcMGCwvBmQOwco8K9d4A+xiahGEK
	WesIvNrjQBX6BUWLMyqtrdJa6t75EzTw/Ew26nKWP47/BemdoF+/ASGJ25+VxElzGcOCp6vRQiH
	QcsvYNHpz4t8rPUmMYAEV7ZE+Md+YyNPlPqk0nGb7opJU5SvkmA9Z9fY/DLqLvPSlwF8tdIgdbn
	vSUtmO30MlKN4J8t89kX1Xe4zSm/eN2Vm5p1eKhwlgLpO9WkQ9Lw0lZkt3OZYexL6xNJj5E8GnY
	aO2o/4CR/k5ZLbZXz7Vc2qdVzb5ksZK8eTpzG13JVmHWCMEhzBP5u+RnXOXOXdEJMjx9uAN9W3+
	r8Grafw++amHah5d4BU+xSJOXsCjvopp0blvSoqhtuG9u5v/n2F59YI8t5Eag/CQQPB17s=
X-Received: by 2002:a05:690e:5c4:b0:667:e80e:1b2f with SMTP id 956f58d0204a3-6699aacc63cmr9316778d50.39.1786058961394;
        Thu, 06 Aug 2026 16:29:21 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:29:19 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 1/6] net: rtnetlink: add pacing_offload_horizon attribute to net_device
Date: Thu,  6 Aug 2026 19:25:58 -0400
Message-ID: <20260806232913.4020403-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The 'max_pacing_offload_horizon' field of 'struct net_device' represents
the maximum pacing offload horizon supported by the device.

Add a new field 'pacing_offload_horizon' to store the active pacing
offload horizon.

The new attribute is initialized to 0 (disabled) and can be set from
userspace via RTM_SETLINK up to dev->max_pacing_offload_horizon. This
new default off behavior does not cause regressions, as no driver yet
advertises max_pacing_offload_horizon.

The equivalent RTM_NEWLINK is absent, as a value may need to be
compared to a device maximum, which may be negotiated with the device
firmware on init, as is the case for the idpf driver in this series.

Make both fields u32, to maintain net_device cacheline layout. This
expresses up to 4s of pacing offload, which is sufficient.

Update the YNL specification ('rt-link.yaml') to add the
'pacing-offload-horizon' attribute and include it in link-all-attrs.

Both fields can be read with

    python3 tools/net/ynl/pyynl/cli.py \
        --spec Documentation/netlink/specs/rt-link.yaml \
        --do getlink \
        --json '{"ifname": "eth0"}' | grep pacing

And the active horizon set with

    python3 tools/net/ynl/pyynl/cli.py \
        --spec Documentation/netlink/specs/rt-link.yaml \
        --do setlink \
        --json '{"ifname": "eth0", "pacing-offload-horizon": 50000000}'

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/netlink/specs/rt-link.yaml      |  6 ++++++
 .../networking/net_cachelines/net_device.rst  |  3 ++-
 include/linux/netdevice.h                     |  4 +++-
 include/uapi/linux/if_link.h                  |  1 +
 net/core/rtnetlink.c                          | 21 +++++++++++++++++++
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 68c26a70bb64..a620135baba3 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1080,6 +1080,10 @@ attribute-sets:
       -
         name: tailroom
         type: u16
+      -
+        name: pacing-offload-horizon
+        type: uint
+        doc: EDT offload horizon setting for the device (in nsec).
   -
     name: prop-list-link-attrs
     subset-of: link-attrs
@@ -2548,6 +2552,8 @@ operations:
             - devlink-port
             - gso-ipv4-max-size
             - gro-ipv4-max-size
+            - max-pacing-offload-horizon
+            - pacing-offload-horizon
       dump:
         request:
           value: 18
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 512f6d6fa3d8..90e257e815b1 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,7 +183,8 @@ struct devlink_port*                devlink_port
 struct dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
-u64                                 max_pacing_offload_horizon
+u32                                 max_pacing_offload_horizon
+u32                                 pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 62cfad7e6b79..93d953caae94 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2131,6 +2131,7 @@ enum netdev_reg_state {
  *		   where the clock is recovered.
  *
  *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
+ *	@pacing_offload_horizon: EDT offload horizon setting in nsec.
  *	@napi_config: An array of napi_config structures containing per-NAPI
  *		      settings.
  *	@num_napi_configs:	number of allocated NAPI config structs,
@@ -2553,7 +2554,8 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
-	u64			max_pacing_offload_horizon;
+	u32			max_pacing_offload_horizon;
+	u32			pacing_offload_horizon;
 	struct napi_config	*napi_config;
 	u32			num_napi_configs;
 	u32			napi_defer_hard_irqs;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 43cecca49f01..7c1d7754a670 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -381,6 +381,7 @@ enum {
 	IFLA_NETNS_IMMUTABLE,
 	IFLA_HEADROOM,
 	IFLA_TAILROOM,
+	IFLA_PACING_OFFLOAD_HORIZON,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31c65a545a10..b8c35f64d49f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1381,6 +1381,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size()
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
+	       + nla_total_size(8)  /* IFLA_PACING_OFFLOAD_HORIZON */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
 	       + rtnl_dev_parent_size(dev)
@@ -2156,6 +2157,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			READ_ONCE(dev->tso_max_segs)) ||
 	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
 			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
+	    nla_put_uint(skb, IFLA_PACING_OFFLOAD_HORIZON,
+			 READ_ONCE(dev->pacing_offload_horizon)) ||
 #ifdef CONFIG_RPS
 	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
 			READ_ONCE(dev->num_rx_queues)) ||
@@ -2324,9 +2327,11 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_MAX_PACING_OFFLOAD_HORIZON] = { .type = NLA_REJECT },
 	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
 	[IFLA_HEADROOM]		= { .type = NLA_REJECT },
 	[IFLA_TAILROOM]		= { .type = NLA_REJECT },
+	[IFLA_PACING_OFFLOAD_HORIZON] = { .type = NLA_UINT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
@@ -2800,6 +2805,13 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
+	if (tb[IFLA_PACING_OFFLOAD_HORIZON] &&
+	    nla_get_uint(tb[IFLA_PACING_OFFLOAD_HORIZON]) >
+	    dev->max_pacing_offload_horizon) {
+		NL_SET_ERR_MSG(extack, "too big pacing_offload_horizon");
+		return -EINVAL;
+	}
+
 	if (tb[IFLA_AF_SPEC]) {
 		struct nlattr *af;
 		int rem, err;
@@ -3317,6 +3329,15 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
+	if (tb[IFLA_PACING_OFFLOAD_HORIZON]) {
+		u64 horizon = nla_get_uint(tb[IFLA_PACING_OFFLOAD_HORIZON]);
+
+		if (dev->pacing_offload_horizon ^ horizon) {
+			WRITE_ONCE(dev->pacing_offload_horizon, horizon);
+			status |= DO_SETLINK_MODIFIED;
+		}
+	}
+
 	if (tb[IFLA_OPERSTATE])
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
 
-- 
2.55.0.679.g6767b8d81c-goog

