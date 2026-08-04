Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7C3EF642
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867675; cv=none; b=KGbmEiRtRCyjED8Ca77hTDYUb+ORBJfqYHiwYUlm4cBYSoDeghjeGHEHiMf86OR/JUulZ5pplQDvcRK6iyV+wjf5wkHY/4xtT5XzVSMOrbjgbajoLht9g3r4MUdadisM/7SyPR+F2U7XJYhjUQPfLEy7DyjsyvyF7Aca3HpNaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867675; c=relaxed/simple;
	bh=f1XPrI9/fXjR2+vnqTH7WyEcTyCk6frVOut6+wmX0i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqQ+clTu3VFAw/JmfxqOgaOuJmNL/KLeCr52+TujSLtLh90YWNq+QnAhgscPcr2gQkNhm5GuYdHaNErM8qnJwE4vg+fW4yHx4XkS5NiPSGC9KF9HBVDk0y1HFv9yDTUcmWLG8eGt5Lge+4EO9PHzqgW8/SuaS1DUnz3XveI9sU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49550ec5b41so133285e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867671; x=1786472471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8KvsUiPTndJmllsvv4uNOZF87lttgUNZFsNjtKN/s+A=;
        b=joY43x9BqPJGXC5zO/ADBVa1BqfB2TVtzt8R45r4WcyvAzJlfCVlDtWwjrlBfOlbic
         uyxmKlCdAHJHKCD3f7bR3WBimbCHtpA3CiZGIarzjWhv9zBGVFPdgh1uigWG/mpTzWHN
         lqd3pTKEMMEWs0aUwZn5kGaEzR5SqzvgqfhZUd+FMiIiEXSxc3WhALlgSqik7DSZZIIN
         1vnW5esjjcQwTR2TMpPUkMrYKthYSsbYxgnLQinWWlHqOGjUAHbGDUkqskMF+k//Tv6i
         v80enq83+JfNNQpZCOEJfzWSv2ZMV4L6+l5Cmxv3FZKbtmA3AqJ1Ks4OFeLBD9+LvFOg
         GiFQ==
X-Gm-Message-State: AOJu0YwvmI/3dkWITAnAOjHypoKSBF8m5LVH5k5nFjhCXKUP8iisc/H2
	9JxD4oSQ8E3K0X9oZL3a1X0fxo/dghPaM3B9FLPK2wU1TV8LllPlDBBcK+fkJ6amu5E=
X-Gm-Gg: AR+sD10R37To+0YoAILL+0+4WPBNytwBMjs48QTkjeuUPstW+KvSGFTvXf/VYFDG9XW
	Ry8rmcS5N7hq6+1ZhvLum+cZwt+lGRhfXg35gO/aJPyodlBjiyCCSnahxN0VsS+twHsLqmgmUQy
	NQF9LUuhigIz7MBBUGumDKSELJ5EfQSP1vD6rERbKf1qUQCWikaGb9cqRKMuIyEfKr0Yes6OaJO
	1XtwWa1kjERDnZsQI8L9JoVOTgwKRvWFQBrPRT1r1siY8pfffPPUZ1CE8fXEzj3iFODuxRA29bu
	4n4FQRWZoW+dXTUWBSw4gV8jq8P6lSughVTvur6cJCi5zgvJ45P/5DqUMnv8t4tJhWMJQ19f7W+
	KJkDnLLO3HPozzbQqQr5QNaGZ2EKrKHuYWl+JWE0LziPMLvuQ6d3KSBRsUiJ9N+hQWHbTiSbLj1
	f7/eNTiQDYzlSiu8/pPZITu8Wz1A7/Ed+AWBTefBXwFGe4psu7S8xkOxE8mbmWkZv8t/7rEan6f
	8/MxEzmrRaUlRfZlE+2NGTlS5IzBQ==
X-Received: by 2002:a05:600c:19cd:b0:498:28b:1045 with SMTP id 5b1f17b1804b1-4994e793f63mr1648365e9.3.1785867670502;
        Tue, 04 Aug 2026 11:21:10 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf5c1sm4946925e9.2.2026.08.04.11.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:21:10 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 2/6] openvswitch: vport: remove infrastructure for vport options
Date: Tue,  4 Aug 2026 20:20:36 +0200
Message-ID: <20260804182049.2289754-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804182049.2289754-1-i.maximets@ovn.org>
References: <20260804182049.2289754-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since removal of tunnel vport types, there aren't any vports that
support options.  Let's remove the options-related infrastructure.

Can be reinstated if we ever need a new vport type or if we need extra
options for the existing ones.  The uAPI attribute remains.

Clarification comment is added to highlight that none of the supported
vports support options at the moment.

If the options are provided, the code now directly replies with
-EOPNOTSUPP to keep the behavior the same for remaining vport types.

Note: It is technically possible that someone has an out-of-tree module
named vport-type-N that implements a different vport type and they have
options for this vport type.  However, our message size calculations do
not account for whatever options such a port would have and so it is
dangerous to load such a module without modifying the code in the main
datapath.c, unless the options are smaller than the ones we had for
vxlan.  A more robust solution would be to have a different version of
the entire openvswitch module instead, so the use case of a separate
vport-type-N loaded with the upstream openvswitch module is unlikely.
At this time we're not aware of anyone doing that.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/datapath.c | 20 +++-----------
 net/openvswitch/vport.c    | 54 --------------------------------------
 net/openvswitch/vport.h    | 14 ----------
 3 files changed, 4 insertions(+), 84 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 0506770341af..57c83f05fead 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1856,7 +1856,6 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	/* Set up our datapath device. */
 	parms.name = nla_data(a[OVS_DP_ATTR_NAME]);
 	parms.type = OVS_VPORT_TYPE_INTERNAL;
-	parms.options = NULL;
 	parms.dp = dp;
 	parms.port_no = OVSP_LOCAL;
 	parms.upcall_portids = a[OVS_DP_ATTR_UPCALL_PID];
@@ -2172,10 +2171,6 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	if (ovs_vport_get_upcall_portids(vport, skb))
 		goto nla_put_failure;
 
-	err = ovs_vport_get_options(vport, skb);
-	if (err == -EMSGSIZE)
-		goto error;
-
 	genlmsg_end(skb, ovs_header);
 	return 0;
 
@@ -2183,7 +2178,6 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	rcu_read_unlock();
 nla_put_failure:
 	err = -EMSGSIZE;
-error:
 	genlmsg_cancel(skb, ovs_header);
 	return err;
 }
@@ -2210,10 +2204,6 @@ static size_t ovs_vport_cmd_msg_size(void)
 	/* OVS_VPORT_ATTR_UPCALL_PID */
 	msgsize += nla_total_size(nr_cpu_ids * sizeof(u32));
 
-	/* There are no vports supporting OVS_VPORT_ATTR_OPTIONS, so it is
-	 * not included in the message size calculation.
-	 */
-
 	return msgsize;
 }
 
@@ -2365,7 +2355,6 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	parms.name = nla_data(a[OVS_VPORT_ATTR_NAME]);
-	parms.options = a[OVS_VPORT_ATTR_OPTIONS];
 	parms.dp = dp;
 	parms.port_no = port_no;
 	parms.upcall_portids = a[OVS_VPORT_ATTR_UPCALL_PID];
@@ -2427,12 +2416,11 @@ static int ovs_vport_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (a[OVS_VPORT_ATTR_OPTIONS]) {
-		err = ovs_vport_set_options(vport, a[OVS_VPORT_ATTR_OPTIONS]);
-		if (err)
-			goto exit_unlock_free;
+		/* There are no vport types that support legacy options. */
+		err = -EOPNOTSUPP;
+		goto exit_unlock_free;
 	}
 
-
 	if (a[OVS_VPORT_ATTR_UPCALL_PID]) {
 		struct nlattr *ids = a[OVS_VPORT_ATTR_UPCALL_PID];
 
@@ -2606,7 +2594,7 @@ static const struct nla_policy vport_policy[OVS_VPORT_ATTR_MAX + 1] = {
 	[OVS_VPORT_ATTR_PORT_NO] = { .type = NLA_U32 },
 	[OVS_VPORT_ATTR_TYPE] = { .type = NLA_U32 },
 	[OVS_VPORT_ATTR_UPCALL_PID] = { .type = NLA_UNSPEC },
-	[OVS_VPORT_ATTR_OPTIONS] = { .type = NLA_NESTED },
+	[OVS_VPORT_ATTR_OPTIONS] = { .type = NLA_NESTED }, /* Unused. */
 	[OVS_VPORT_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
 	[OVS_VPORT_ATTR_NETNSID] = { .type = NLA_S32 },
 	[OVS_VPORT_ATTR_UPCALL_STATS] = { .type = NLA_NESTED },
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 12741485c939..ada316a61726 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -239,22 +239,6 @@ struct vport *ovs_vport_add(const struct vport_parms *parms)
 		return ERR_PTR(-EAGAIN);
 }
 
-/**
- *	ovs_vport_set_options - modify existing vport device (for kernel callers)
- *
- * @vport: vport to modify.
- * @options: New configuration.
- *
- * Modifies an existing device with the specified configuration (which is
- * dependent on device type).  ovs_mutex must be held.
- */
-int ovs_vport_set_options(struct vport *vport, struct nlattr *options)
-{
-	if (!vport->ops->set_options)
-		return -EOPNOTSUPP;
-	return vport->ops->set_options(vport, options);
-}
-
 /**
  *	ovs_vport_del - delete existing vport device
  *
@@ -348,44 +332,6 @@ int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 	return 0;
 }
 
-/**
- *	ovs_vport_get_options - retrieve device options
- *
- * @vport: vport from which to retrieve the options.
- * @skb: sk_buff where options should be appended.
- *
- * Retrieves the configuration of the given device, appending an
- * %OVS_VPORT_ATTR_OPTIONS attribute that in turn contains nested
- * vport-specific attributes to @skb.
- *
- * Returns 0 if successful, -EMSGSIZE if @skb has insufficient room, or another
- * negative error code if a real error occurred.  If an error occurs, @skb is
- * left unmodified.
- *
- * Must be called with ovs_mutex or rcu_read_lock.
- */
-int ovs_vport_get_options(const struct vport *vport, struct sk_buff *skb)
-{
-	struct nlattr *nla;
-	int err;
-
-	if (!vport->ops->get_options)
-		return 0;
-
-	nla = nla_nest_start_noflag(skb, OVS_VPORT_ATTR_OPTIONS);
-	if (!nla)
-		return -EMSGSIZE;
-
-	err = vport->ops->get_options(vport, skb);
-	if (err) {
-		nla_nest_cancel(skb, nla);
-		return err;
-	}
-
-	nla_nest_end(skb, nla);
-	return 0;
-}
-
 /**
  *	ovs_vport_set_upcall_portids - set upcall portids of @vport.
  *
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 9f67b9dd49f9..636788b59907 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -34,9 +34,6 @@ void ovs_vport_get_stats(struct vport *, struct ovs_vport_stats *);
 
 int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb);
 
-int ovs_vport_set_options(struct vport *, struct nlattr *options);
-int ovs_vport_get_options(const struct vport *, struct sk_buff *);
-
 int ovs_vport_set_upcall_portids(struct vport *, const struct nlattr *pids);
 int ovs_vport_get_upcall_portids(const struct vport *, struct sk_buff *);
 u32 ovs_vport_find_upcall_portid(const struct vport *, struct sk_buff *);
@@ -92,8 +89,6 @@ struct vport {
  *
  * @name: New vport's name.
  * @type: New vport's type.
- * @options: %OVS_VPORT_ATTR_OPTIONS attribute from Netlink message, %NULL if
- * none was supplied.
  * @desired_ifindex: New vport's ifindex.
  * @dp: New vport's datapath.
  * @port_no: New vport's port number.
@@ -104,7 +99,6 @@ struct vport_parms {
 	const char *name;
 	enum ovs_vport_type type;
 	int desired_ifindex;
-	struct nlattr *options;
 
 	/* For ovs_vport_alloc(). */
 	struct datapath *dp;
@@ -120,11 +114,6 @@ struct vport_parms {
  * a new vport allocated with ovs_vport_alloc(), otherwise an ERR_PTR() value.
  * @destroy: Destroys a vport.  Must call vport_free() on the vport but not
  * before an RCU grace period has elapsed.
- * @set_options: Modify the configuration of an existing vport.  May be %NULL
- * if modification is not supported.
- * @get_options: Appends vport-specific attributes for the configuration of an
- * existing vport to a &struct sk_buff.  May be %NULL for a vport that does not
- * have any configuration.
  * @send: Send a packet on the device.
  * zero for dropped packets or negative for error.
  * @owner: Module that implements this vport type.
@@ -137,9 +126,6 @@ struct vport_ops {
 	struct vport *(*create)(const struct vport_parms *);
 	void (*destroy)(struct vport *);
 
-	int (*set_options)(struct vport *, struct nlattr *);
-	int (*get_options)(const struct vport *, struct sk_buff *);
-
 	int (*send)(struct sk_buff *skb);
 	struct module *owner;
 	struct list_head list;
-- 
2.55.0

