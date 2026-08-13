Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1C3B8D75
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656168; cv=none; b=tPcKq2uZIVflGcpbibl6Q6QT7BSaofnS5ZfPEhR2B8rqDVkFs+j0hkRODzY8c74zCuc2QoMZxmHs/QTY9ZAZh6YMAqeiv80HRrdGE6AzujqIEIrxjQk4ODQNbo0eLrz+j+kCsiZ4uQSFBB1Aik9F8jcjAXpWjGbdtuhSDPcLax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656168; c=relaxed/simple;
	bh=qRS5jXeOTW+CIQf24Efobx/EkOQrRUGxHcorL3gAU4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lc/okQBWba6veulKPaG70wEiJBrTbgfKjnFQC2qh+k2BWv7PXs5ABwgpqr49pQwzP+p46dCRXsIol1jfnd92/kO7EIq0XxU+w1QKleesrhwp1gUSLsvj3LVVym9bjBkoCDX1BDE6o8XkopsaU0039CdN7pgqM6W78HYX6x5s3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498074920dcso1441165e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 14:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786656162; x=1787260962;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8IbpkXp6wWJnlmGsygCaezZPnhcQVllPz56jds9WM8=;
        b=KfeMq2VLMl4xJP+963f+TZ7Gdxib8s801o1SRC20Ht070rXKX69qDwURgv8aNAdyLU
         aDeRjkjMi9oBs+GTIBOGa+63hu93w/TKT2qQvXS8y/gAupb3NeA5dge68r+mTNwxe30h
         ESlTIT3pOydWneOiZHVq5207vANgrY0Wj20pPtQ47Ig3Dzqov5Y2ag8Tjj9guqqpF3Dc
         rBjmvUEVtKd1YoC2Rt9KWVI0W63u/dc1O+wjxeoOta5bIUt9qelOi6IKRUsdsyuOGOkG
         YQlldlyuMvAFGEeB0jpdSl06+IIsVgsSwYwQNn91L5xBj4eveKRf2kWOsLZf4myA422U
         zEfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJldMdF4w7o8OM0kCZekyfeeKAv7fiFHnkkwBKmkz68er6Wu8IYlMwJ9BGhGmbrMZO5ddthv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9p+2AiRAS24YRR8Qbe5XM8DwekhN0nUX+mCDV5gC+h6pERyIb
	fuCi7W1hGfbwUr2mb/FdIE5oX79e4TEtnl7MH7MCwGYhSfKip8USJun+
X-Gm-Gg: AR+sD12PYS4EnTeNPggwKYUoUnq6Bb65ye0folsHrEMWxinnHUrQ8vFdHFD+EYCgMSK
	YX9X0F90tmSfCO8BfIK7qrFXvGzVklxMjVm0UjGbJxRdfO8Jr4U76UU5O0hHiTIfKSOUxofFRaU
	O2N+OvRRzBk11VBNZC7SlsWP6OCsNM4Xc0kWxEfcw7e30BerWWwf6ueVlDWgx7CM/C6cMC9X5AA
	koXWPiQBMkkQOlG4L3Wh4jAHEvEihQ+0QMbvylBW8Dnx7SQAVK6bMvxD0BUEx3OvdX+2RhmppQX
	VsfFoVxJBPMwJ0E7dh9HTQIlMOojRSIISm0RqieDNTbGJ09JVG+d2EPYFS95V5l8iPf31U3TTjC
	KTLmYIajDBdXjP/Vd3ecLosKlPVYCTsX5X5Edvcr7iIcy5flu/PY7lWIlg/ckJzLHdukHFxjJmN
	LkNpwnFbJbGQWrpmKScFs+EE2jnzO4UC29Ua2hUVFWa2haiObqMoqnwrUmMMsgpEY5urwj5prTs
	EY28owEFnPdl99E
X-Received: by 2002:a05:600c:1d1a:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4998797335amr13451785e9.9.1786656162126;
        Thu, 13 Aug 2026 14:22:42 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499821652dbsm91202755e9.9.2026.08.13.14.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 14:22:41 -0700 (PDT)
Message-ID: <43ebb641-0ecf-479e-9e21-c2daeefa5686@ovn.org>
Date: Thu, 13 Aug 2026 23:22:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Ilya Maximets <i.maximets@ovn.org>, Yuqi Xu <xuyuqiabc@gmail.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Vega <vega@nebusec.ai>, Nan Li <tonanli66@gmail.com>,
 Ren Wei <enjou1224z@gmail.com>
References: <cover.1786506548.git.xuyuqiabc@gmail.com>
 <a265fa4d69ec48176312f98381f8bb43347fcff1.1786506548.git.xuyuqiabc@gmail.com>
 <12c4319a-c3f2-4b64-bfbf-44cd5722055a@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <12c4319a-c3f2-4b64-bfbf-44cd5722055a@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 2:15 PM, Ilya Maximets wrote:
> On 8/12/26 11:59 AM, Yuqi Xu wrote:
>> Packet processing uses CT limit state under RCU, while netns teardown
>> frees that state under ovs_mutex. The CT limit pointer was neither removed
>> from readers nor protected by a grace period, allowing packet processing to
>> dereference the freed state.
>>
>> An unprivileged user can trigger this bug from a user and network
>> namespace, causing a slab-use-after-free in ovs_ct_execute() when the
>> netns is torn down.
>>
>> Publish the CT limit pointer through RCU, remove it before teardown, and
>> wait for readers before freeing its contents. Keep ovs_mutex around
>> individual CT limit updates, and use the RCU read-side lock while GET
>> traverses the RCU-protected limit lists.
>>
>> The netlink command handlers do not need NULL checks because the userspace
>> netlink socket holds an active reference to its network namespace while a
>> request is processed. The per-netns exit path therefore cannot run
>> concurrently with SET, DEL, or GET for that socket's namespace.
>>
>> The teardown path currently waits for the RCU grace period while holding
>> ovs_mutex. Moving synchronize_rcu() outside the mutex would require
>> restructuring the teardown path and is left for a separate change.
>>
>> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
>> Cc: stable@vger.kernel.org
>> Reported-by: Vega <vega@nebusec.ai>
>> Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
>> Assisted-by: Codex:GPT-5.4
>> Co-developed-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
>> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
>> ---
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

Hmm.  LLMs keep complaining about the RCU synchronization under the mutex,
which is a valid concern at the end of a day.  So, maybe we should fold
something like this in instead of fixing it later:

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index cc6ea4014c16..e39724390654 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1620,13 +1620,20 @@ static int ovs_ct_limit_init(struct net *net, struct ovs_net *ovs_net)
 	return 0;
 }
 
-static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
+static void *ovs_ct_limit_exit_start(struct ovs_net *ovs_net)
 {
-	const struct ovs_ct_limit_info *info;
+	return rcu_replace_pointer(ovs_net->ct_limit_info, NULL,
+				   lockdep_ovsl_is_held());
+}
+
+static void ovs_ct_limit_exit_finish(struct net *net, void *data)
+{
+	const struct ovs_ct_limit_info *info = data;
 	int i;
 
-	info = rcu_replace_pointer(ovs_net->ct_limit_info, NULL,
-				   lockdep_ovsl_is_held());
+	if (!info)
+		return;
+
 	/* Wait for RCU readers to stop using the CT limits. */
 	synchronize_rcu();
 
@@ -2029,12 +2036,27 @@ int ovs_ct_init(struct net *net)
 #endif
 }
 
-void ovs_ct_exit(struct net *net)
+/* Must be called with ovs_mutex held.  Detaches RCU-protected ct_limit_info
+ * and returns an opaque handle for ovs_ct_exit_finish() to complete teardown
+ * after the mutex is released.
+ */
+void *ovs_ct_exit_start(struct net *net __maybe_unused)
+{
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
+	return ovs_ct_limit_exit_start(net_generic(net, ovs_net_id));
+#endif
+	return NULL;
+}
+
+/* Must be called without ovs_mutex held.  @data must be the opaque pointer
+ * returned by ovs_ct_exit_start().
+ */
+void ovs_ct_exit_finish(struct net *net, void *data __maybe_unused)
 {
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	ovs_ct_limit_exit(net, ovs_net);
+	ovs_ct_limit_exit_finish(net, data);
 #endif
 
 	if (ovs_net->xt_label)
diff --git a/net/openvswitch/conntrack.h b/net/openvswitch/conntrack.h
index 317e525c8a11..8c4aa7b8a563 100644
--- a/net/openvswitch/conntrack.h
+++ b/net/openvswitch/conntrack.h
@@ -14,7 +14,8 @@ enum ovs_key_attr;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 int ovs_ct_init(struct net *);
-void ovs_ct_exit(struct net *);
+void *ovs_ct_exit_start(struct net *);
+void ovs_ct_exit_finish(struct net *, void *data);
 bool ovs_ct_verify(struct net *, enum ovs_key_attr attr);
 int ovs_ct_copy_action(struct net *, const struct nlattr *,
 		       const struct sw_flow_key *, struct sw_flow_actions **,
@@ -40,7 +41,8 @@ void ovs_ct_free_action(const struct nlattr *a);
 
 static inline int ovs_ct_init(struct net *net) { return 0; }
 
-static inline void ovs_ct_exit(struct net *net) { }
+static inline void *ovs_ct_exit_start(struct net *net) { return NULL; }
+static inline void ovs_ct_exit_finish(struct net *net, void *data) { }
 
 static inline bool ovs_ct_verify(struct net *net, int attr)
 {
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index ae69b2cabab9..c18dafa920b7 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2758,15 +2758,16 @@ static void __net_exit list_vports_from_net(struct net *net, struct net *dnet,
 
 static void __net_exit ovs_exit_net(struct net *dnet)
 {
-	struct datapath *dp, *dp_next;
 	struct ovs_net *ovs_net = net_generic(dnet, ovs_net_id);
 	struct vport *vport, *vport_next;
+	struct datapath *dp, *dp_next;
+	void *ct_exit_data;
 	struct net *net;
 	LIST_HEAD(head);
 
 	ovs_lock();
 
-	ovs_ct_exit(dnet);
+	ct_exit_data = ovs_ct_exit_start(dnet);
 
 	list_for_each_entry_safe(dp, dp_next, &ovs_net->dps, list_node)
 		__dp_destroy(dp);
@@ -2784,6 +2785,8 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 
 	ovs_unlock();
 
+	ovs_ct_exit_finish(dnet, ct_exit_data);
+
 	cancel_delayed_work_sync(&ovs_net->masks_rebalance);
 	cancel_work_sync(&ovs_net->dp_notify_work);
 }
-- 

WDYT?

Best regards, Ilya Maximets.
