Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664B38E5ED
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445101; cv=none; b=SZAj/2HtEYmPm65xX3sAlDvG+39sVhHkfxUw6ghQq8pAjIQcR/yga+QwWIZtstunnh7x6zspN33POcNLcpGLoTxoU8jOkh8DHymWpD5n0xRjEXNxNFgZcWdtBlJoaPHyJ1TzmrkJQW/lC6dT87CFZxBmWLZ9qxrd9tzIJd0fZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445101; c=relaxed/simple;
	bh=EmUMS+ZRzCUeb0rndVpz/BHk6ngRvxk7aEnRstACYI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgTPOk27q8YtUr9v9ss/ZIW25KCEqR9Btbv5V1lIrciYX1cMogzww/XS+cxmw3kb79lOfX6tl++mnC3a73gWEkWBS6PeaY4yFW6i1CsXrZ+oiF6Mq3lXWFxlcrCcK8N4sHzJ/cTd9njS59eY6NRnRBBJwKl6odvK9DRFgKIOzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibjg0SkZ; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibjg0SkZ"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3427977d677so125676eec.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790445097; x=1791049897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kh+HhJ5EU4L73Wf3xyAcV+eWsVVzfBMuFzfcoxTkNvA=;
        b=Ibjg0SkZLWdzPAHEzVIIlRd6aCMrNvPDNR+ALjtYaCw5nwVmXvx+awxsRA/Fo13rDn
         6Jd4sCBzGuQTfuTpazTUd7X43jGcGL2KqJWFlE4AxDsJ1OLKbinJOkWvteCoJTGwas//
         dlMnR8cq3fFpEOPCaBUSr59dKns6KROS8Ao8oP+Er/txKkSkiLANM5AfpzupXWKJXBDd
         ZFBChXnIeW2gbeb9OPFi5uTbaqbWH/0ix0MAizVGkQ0GdBXZp3q2tYMXBWc+553APZFM
         JXDlraeDWKLamSVUTYrJOpRBfUEgfE/wXvdNauczCMqcMsQufJ/NXc7UF7VKiABhlJNX
         Sd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790445097; x=1791049897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kh+HhJ5EU4L73Wf3xyAcV+eWsVVzfBMuFzfcoxTkNvA=;
        b=lhhHlnh/CGgoz+FKqOOvrVaWUXcVDpQZs3uRM/rTtUOM8a4u/ouuaPCwUPhqf+mMIo
         UJ8PQBXi5E7t+18qSdKGy2E1zD4dcPpjoE0ZWKPXumwTBdUiksChu98jJvP4UPsMnCZE
         80yDR70Od+cxJxPl5Y2Ff8kctU+IJ2sy08OFZRf3dQtGqSwdtOry2VQLm+lxcx+BOsDP
         JoEhj8p1cgYmVpfV1ceoF9RsbJ7xKRKutv+tMtYq8yzHPyFNHowhyZMFnj3wZN9gNMQg
         Hfsmxb/AgD1KxqAiGHbgied8FJDDfR4GPNrClVacMP1mqlPxRB6f9CAro3mjKbMpNQQ8
         OgXw==
X-Gm-Message-State: AFq9FYInJUHEIRD2lB471Pfq8eJ9UVJxLW/AXYtoCtkGsiEq7JB8uTX+
	x5/s7tgPr5CcVeqyePvvd9+k9JCgrWgRR6D0idfMwciguPxstZq2UNGY
X-Gm-Gg: AYBFou2ylgn5yOqCGYzZQrFwu6c3Xjc+DzjE55S5MSjqopWBHQ2AZKtBtHx2ZkdjzdH
	8xgACnx0Mg2wlozF62B8nTf5ngIS28FF7CHmxfSnjk9wbzBw57EyxG96VNhWz4ca8yHN+sldBLR
	daafh7s9k2F7482MdP14LsvadpKqGomq2J8YV+lU261/qFq6YifiQqJVNNTLFisSgoBQRf9L7va
	7AnAEN0WPC3+Zc/jnL2TIes2K4C64MCJzH5a8/TDvGIGpfbDf54aOOhF/gSy/tSh6ReEf2ldwwK
	irf4SSHa5ANsphkwBAyPrrgMwsq/DIS3ODEOTpZVlWfCXA2dI19AwgZJp3GmRoGzFcPP7w9go4R
	A8M3nbxRBJco5K/aRN65tePmt8qMPuUxVHadJjLT2o97UfH5SJg6t7gbolFQl6NzfN4VVgmYp+r
	S5YJCumrqbBoqDA6Z3c265jajQPSJS0k0I4hT0AsfBZNcOTo5Is0HF6aiTaCeu+J8i2lx2CF3bf
	SrjKWm1QKOVnUYlQWX9gtmUOiAg4+1qJNyrKCBkwZjmlQYRNniCssad7Rob5Ml0332eoA==
X-Received: by 2002:a05:7301:540e:b0:33c:1bd2:1db6 with SMTP id 5a478bee46e88-3426d0df371mr5641086eec.0.1790445096797;
        Sat, 26 Sep 2026 10:51:36 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341459234a1sm15872673eec.24.2026.09.26.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:51:36 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] ipvs: Defer application parent freeing until after RCU readers
Date: Sun, 27 Sep 2026 01:51:29 +0800
Message-ID: <20260926175129.2612644-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unregister_ip_vs_app() removes each incarnation from its protocol list and
uses call_rcu() to defer freeing it, but frees the parent application
immediately. An RCU reader that already found an incarnation can still
access the parent through inc->app in ip_vs_app_inc_get().

During FTP helper module unload, the following interleaving is possible:

  CPU 0 (RCU reader)                 CPU 1 (module unload)
  tcp_app_conn_bind()
    find inc in protocol list
                                     unregister_ip_vs_app()
                                       ip_vs_app_inc_release(inc)
                                         list_del_rcu(&inc->p_list)
                                         call_rcu(&inc->rcu_head, ...)
                                       kfree(a)
    ip_vs_app_inc_get(inc)
      try_module_get(inc->app->module)

The helper module is already going away, so try_module_get() would fail,
but evaluating its argument first reads the freed parent. The subsequent
rcu_barrier() in pernet unregistration cannot protect this earlier free.
KASAN reported:

  BUG: KASAN: slab-use-after-free in ip_vs_app_inc_get+0x7c/0x90
  Call Trace:
   ip_vs_app_inc_get+0x7c/0x90
   tcp_app_conn_bind+0x1bc/0x290
   ip_vs_conn_new+0x1915/0x20d0
   ip_vs_schedule+0x697/0xea0
   tcp_conn_schedule+0x489/0x820
   ip_vs_in_hook+0x7bf/0x1f40
  Allocated by task 88:
   kmemdup_noprof+0x20/0x50
   register_ip_vs_app+0x12d/0x2c0
   __ip_vs_ftp_init+0x56/0x160 [ip_vs_ftp]
  Freed by task 104:
   kfree+0x131/0x3c0
   unregister_ip_vs_app+0x2f4/0x5b0
   unregister_pernet_operations+0x232/0x490
   unregister_pernet_subsys+0x1c/0x30
   __do_sys_delete_module+0x346/0x510

Use kfree_rcu() with the existing rcu_head to keep the parent alive until
these readers finish. Successful helper references already prevent normal
module unload, and incarnation RCU callbacks do not access the parent.

Fixes: 363c97d7435e ("ipvs: convert app locks")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/netfilter/ipvs/ip_vs_app.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_app.c b/net/netfilter/ipvs/ip_vs_app.c
index 11cbdbaf561d..2c1b47702da2 100644
--- a/net/netfilter/ipvs/ip_vs_app.c
+++ b/net/netfilter/ipvs/ip_vs_app.c
@@ -242,7 +242,7 @@ void unregister_ip_vs_app(struct netns_ipvs *ipvs, struct ip_vs_app *app)
 		}
 
 		list_del(&a->a_list);
-		kfree(a);
+		kfree_rcu(a, rcu_head);
 
 		/* decrease the module use count */
 		ip_vs_use_count_dec();
-- 
2.43.0

