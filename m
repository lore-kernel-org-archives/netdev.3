Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E23101A9
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073180; cv=none; b=jkt+j4ptSBxI0tAc9seNbg3ecvw6Uh4zZhTJCzVeNk9syGGtGCEzca3cNAjUXRSshsJNhBZQdTYCxTzgzPVSKKADz0Wg4N5q1xnIy652EIjmKF35fsXld9jutfIo1CyM5olbaeyOSMCJZtgASrfOn84lmDSkLLEJ7V1BYOn/wp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073180; c=relaxed/simple;
	bh=zi7EJYk7oIZzV6B6pUlpREqt+q3IS8JYhLbpmpAPuYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZL31SavqTdoO8ThSyccNv+To5S1Bb/jJsCqfJmptzHuc4RGO8WQdlcBmiqBI85f4FDxrIaUEimUuyRMvH+YhJ4+VmZS3KsXsliZlD2fiV/InMaCd/GtoJR0gJt6fHSwWGyaydVU4m2EIigKsqbK/gydkRDUML0LK4NhvRS13xME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6gy/qkO; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6gy/qkO"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530006c6d43so3810621cf.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789073178; x=1789677978; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TijCjfZTrOvz4pb9FRTKmatqMkccxrhS1/Ib6rjgZl4=;
        b=u6gy/qkOsCOCjT0gUarrZ9otnEaQXcuDRR8f91MvHmewAIoZZunEmlX6lKg/25rrvk
         43hSGwMPWP5Tug4twNolhyHbdcdl3mbnScVVsQP3iyCzHTbdxrMakwKo7KdLOc/TaPQK
         8nrT1+JgXKXhm17lB6mpoOgOfUp24kD92+lceWF69JzCE3KsMrdH9eMQvgsiO3aoWZFW
         QsxluyUMpo5K1l9HC9pdhP13vLsQFddHgwHvoSalAuXFBbF/yLDY/iq9yaBhe0HfGIbS
         aDwqyD7W1TBjnjMi/xWvUx+xfdDm/lufxCUQ9e3gqq9BKnaLFqcMoXFK5TgymNfAf8w1
         +QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073178; x=1789677978;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TijCjfZTrOvz4pb9FRTKmatqMkccxrhS1/Ib6rjgZl4=;
        b=dzTlPAUpDQQA1+Y0OIRBhMjnyw9EVTfyOJxLS3m/xRdx8KsebS2L8eJ0jFrlA7feOS
         NxYvHWk8XAqDOg8wDOf3cui9FTqd/dEdmEC1QdpPWwh1k6nnyyDWPlGIix9b8ArJMoBz
         bETRYZ6JNQMEf4/23eq9tGe2EgiY9UkgYH5TnUq2KbJxC58LZyih+zzETHNKxVVjBHAG
         kX0Is1ce/VEbl6t4t71bsXQymAqYQziKNSvX/mKuFMiDI4qR5FUmwYzw8HIjQWZDbQML
         fXRlKFQ6g/wMw9m070xaOktXAkmsBH74/Y+VTWkyobknyj7/1/oGa5HATjFvdXNoddwa
         DECw==
X-Forwarded-Encrypted: i=1; AKwUvBxq2GJhESD493o7nV8WEauAGimTAy1M4uN27QuphdIixVutaYxLknYt71mUGc0R4ijJUTPikiI=@vger.kernel.org
X-Gm-Message-State: AFuF++kfuAj72vKN2fneAV5MrFWFPkmBjq7m/4HkA8vz0d3LkuWbzKsA
	QocnFXmzcVVAipdmKFtHlI2lMIx7SbGHAI15pZEPJCd5BeIkr8IKd7fEXGxzQaWWnxDp+FGEMUA
	45ZVmUZhCKtmbYQ==
X-Received: from qtbnx8.prod.google.com ([2002:a05:622a:7c88:b0:530:a345:fdaf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:514:b0:530:b2e4:91bc with SMTP id d75a77b69052e-530c878ffdamr19050311cf.53.1789073177524;
 Thu, 10 Sep 2026 13:46:17 -0700 (PDT)
Date: Thu, 10 Sep 2026 20:46:09 +0000
In-Reply-To: <20260910204612.3762015-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910204612.3762015-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910204612.3762015-2-edumazet@google.com>
Subject: [PATCH net 1/4] drop_monitor: synchronize tracepoint unregistration
 on error path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If register_trace_napi_poll() fails in net_dm_trace_on_set(),
unregister_trace_kfree_skb() is called to roll back the kfree_skb
tracepoint registration.

However, tracepoint_synchronize_unregister() is omitted before calling
cancel_work_sync() and module_put(). An in-flight probe executing
concurrently on another CPU could call schedule_work() after
cancel_work_sync() has already returned, leaving a pending work item
scheduled after the module reference is dropped. If the module is then
unloaded, executing the work item triggers a kernel panic.

Add tracepoint_synchronize_unregister() after unregister_trace_kfree_skb()
in the error path, matching net_dm_trace_off_set() and
net_dm_hw_probe_unregister().

Fixes: 7c747838a558 ("drop_monitor: Split tracing enable / disable to different functions")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/drop_monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index abaf108ac4db8c762c23f1d9c708c687ee36c7c9..018d19e3a71de0be50bcc5753ba65f715f678aaa 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1173,6 +1173,7 @@ static int net_dm_trace_on_set(struct netlink_ext_ack *extack)
 
 err_unregister_trace:
 	unregister_trace_kfree_skb(ops->kfree_skb_probe, NULL);
+	tracepoint_synchronize_unregister();
 err_module_put:
 	for_each_possible_cpu(cpu) {
 		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
-- 
2.55.0.1007.g17ff1f9808-goog

