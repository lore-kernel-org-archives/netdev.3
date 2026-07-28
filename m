Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A0421F18
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234880; cv=none; b=HPLUSa7aKmVUvhqtVOfZ66UQF9bOe4oipCx0CQ+8nVBPUztMvB5VOs6n7MQYpxnm+rq008V3C+MNGYzMt5bJkyvZM1pRZSf0p9KkdNR35L0QjI6lRs6rdoor7GcmrVyfKIcl1tMzenyipZYnCH8lz7DSPsrIoNMnC+UraFpHSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234880; c=relaxed/simple;
	bh=LT/S5/RTKji/bNPUDq6Rj/EjZf1QYtHX1ZfD0Xh1oas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0TYwnHLo5/pKvQ6CF4YXlibyigjQr4DowzXEFLyrmwgtHLjsKWeiPMx2TMx1JDszDDoz7T24BQrkkvjP/Iuk5QqGlvUxKsarEeRDGl2usiPYS2+au4w1hRetKx32vHmkzY/SfIEhVlkfoXfsuY+0RhDQALHABEAbJR3muGahcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxEzkfOi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDtX1kKr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxEzkfOi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDtX1kKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785234877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xdQhFpRWUzD9Fj2435WhQROQlSe5SUcwou//jy23Pg=;
	b=UxEzkfOi9QL/oUTJAQ2irzHE7RHXCbzdoe+s+NB6LEWpBka0zMYFGbJdPELEld+ESMlVme
	r2MD9dk7SgTDEH8f7MPBDMjPeaYYdm78T7z8KgmgR0dI3fq0D1iw2ODEfhCuPDKGJW+h92
	97fwUH8vTzNWsKzhjlfIhyDESmwUpUk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-NoOPqxULPLGVbz5_McZ5gA-1; Tue, 28 Jul 2026 06:34:36 -0400
X-MC-Unique: NoOPqxULPLGVbz5_McZ5gA-1
X-Mimecast-MFC-AGG-ID: NoOPqxULPLGVbz5_McZ5gA_1785234875
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f84ac1990so2404251f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785234875; x=1785839675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xdQhFpRWUzD9Fj2435WhQROQlSe5SUcwou//jy23Pg=;
        b=RDtX1kKrB36BZVfkt4ovjOC8ZVb9a0eF8NKn8qGmhUl9qrpLCgHI6yMqIM33mOwosp
         G+vJ+H3v+iQQm7wxL2XRileWi1WsvRxsws5n9n0seAYLRgiwmAqxygAWujeWcU/UGBiq
         LXkOMIc2VcTEfNgT3i+m0TVRFU8dO3k1J+wUA8DoKPFY5TVzkuIUVn8dh5Z8QyObueXy
         Y4KEcKMYkbAYVAJFlVP4Q4eQGmfCvYAAgpjXtQDZ5EhKTv8b3Am9wUK2kuO8WKHGuBn+
         uHxXcqLJZGVRnr/uOOSELQLa2n+V0Pf11xaLD7YbIj+41gaaTaPQ2XPWRRE+/acR7fT6
         /i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785234875; x=1785839675;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xdQhFpRWUzD9Fj2435WhQROQlSe5SUcwou//jy23Pg=;
        b=n8GSBEeLtzFUtINu3Wg9sLeFB13D5DktNcHh5qQqyUGAaTmjSpN27GQ9W54hbnoMem
         vzBeOEoL6bZ1yWfCIn7zomGIXwAH0ZGWN7V0nGi+THkiEvQ+bH4dwTaMK+9P1Gbsk26i
         rxkw+ZEfp1VKcS9kcjHGk9EM/NUfBTSRgyIJwvYkWueoyMQfg8ZHdj7MkTctbwg/RKlF
         RxdzzGzpyQnMtQ0PNSkVLBccycI28LkgGeW7IstPMBhTWEgXRzueE4/+OhFF/ZVvJ94W
         vdFi/os0X9nQq+gJzryg3ETk7ypFb3nAtDICNqrMQE85euQDBxBw2FDhSZw0KHwYJlx0
         kslA==
X-Forwarded-Encrypted: i=1; AHgh+RpdHdjYc2WoSKHG3isaTxkycHqXg+Qqr4kmddVekAmp68xaK/I9g07olL+zBeLtlCeV+XEBbLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPaAm5ahZPCgOqyajT9RZsBqV/wibgkoNgFkh2M31n31/j8B4t
	hyomRw5rzP6v1EinC4ZLnCl+nPSrDCmbsqpNp63lDwRRTBdNOzG4IXwj6Yw3+EfEvrdy0OcbsjR
	j7PHlVtHjnbqNAGMGRHSpOP1ceYmiF4i8KTuSA1IEKvyFDHU0pAv0squOig==
X-Gm-Gg: AR+sD11Oyihi03T8NeL5TX42Sna2d3Dc498Z/3vzb9/ZQ92iW2ClLLR0+bSLRibD+cM
	OzbskmnlLigFNkAjN3EcZaakdO37Lwo7dMZeCtiPJSTgDktDVGvCc+v80FtAp5gY4DQ2yECXxEv
	C+HsEzl++wPeKMmKa+Q/ct2SQwwEZUZPTNGmAhOVU2j/Dj+wUJ78zvRZ6QYRrl9K1g2K24jB2ml
	EKXJCyxOELrGweNGWfOMk9OMtV42W8+ZJjmxs8I//SHqMcNjkxap79rC7GbPI2ayNYUOkceIqbQ
	PbFpaI5N+Kzpt+mmqJn68Bi758VhYsg4bTvqDVzRyT+O/dkr5TUDzdmusVt092vzxBePUjvJlL+
	D9LUcKj1Bfwd+3LMqUMR7Waj7IYTenwqDTGDBO+ox/ZgJJ7V6s0b+oQ/taO3M3S+OzSI+SANGMx
	1nMA==
X-Received: by 2002:a05:6000:4283:b0:47f:826c:7422 with SMTP id ffacd0b85a97d-47fb1e70bebmr1968712f8f.17.1785234875145;
        Tue, 28 Jul 2026 03:34:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4283:b0:47f:826c:7422 with SMTP id ffacd0b85a97d-47fb1e70bebmr1968677f8f.17.1785234874656;
        Tue, 28 Jul 2026 03:34:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm56558149f8f.9.2026.07.28.03.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 03:34:34 -0700 (PDT)
Message-ID: <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
Date: Tue, 28 Jul 2026 12:34:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, john.fastabend@gmail.com, jiri@resnulli.us,
 zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com,
 victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org,
 Santosh Kalluri <santosh.kalluri129@gmail.com>
References: <20260723105210.817079-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260723105210.817079-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 12:52 PM, Jamal Hadi Salim wrote:
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index bd6f945bd388..700f878fc3cd 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -297,16 +297,29 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
>  					next = rtnl_dereference(f->next);
>  					RCU_INIT_POINTER(b->ht[h2], next);
>  					tcf_unbind_filter(tp, &f->res);
> -					if (tcf_exts_get_net(&f->exts))
> -						route4_queue_work(f);
> -					else
> -						__route4_delete_filter(f);
> +					/* Always defer the free.  The direct
> +					 * __route4_delete_filter() path has no
> +					 * grace period and races with readers
> +					 * that cached f in the fastmap.
> +					 */
> +					tcf_exts_get_net(&f->exts);
> +					route4_queue_work(f);

Sashiko fears the above would be race prone:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com



>  				}
>  			}
>  			RCU_INIT_POINTER(head->table[h1], NULL);
>  			kfree_rcu(b, rcu);
>  		}
>  	}
> +
> +	/* All filters are unlinked; no new reader can find them on the
> +	 * chain.  Wait for in-flight readers that may still hold a filter
> +	 * pointer and have published it into the fastmap after we unlinked.
> +	 * Then flush the stale entries while head is still valid under
> +	 * RTNL, matching the route4_delete() pattern.
> +	 */
> +	synchronize_rcu();
> +	route4_reset_fastmap(head);

This really looks like quite a big hammer. Since there is already a 
synchronization point for both reader and write while acquiring the 
fastmap_lock, I'm wondering if something alike the following could work ?!?
(completely untested!!!):

---
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index bd6f945bd388..8cecc945dcde 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -52,6 +52,7 @@ struct route4_filter {
 	struct tcf_result	res;
 	struct tcf_exts		exts;
 	u32			handle;
+	bool			dying;
 	struct route4_bucket	*bkt;
 	struct tcf_proto	*tp;
 	struct rcu_work		rwork;
@@ -66,9 +67,11 @@ static inline int route4_fastmap_hash(u32 id, int iif)
 
 static DEFINE_SPINLOCK(fastmap_lock);
 static void
-route4_reset_fastmap(struct route4_head *head)
+route4_reset_fastmap(struct route4_head *head, struct route4_filter *f)
 {
 	spin_lock_bh(&fastmap_lock);
+	if (f)
+		f->dying = true;
 	memset(head->fastmap, 0, sizeof(head->fastmap));
 	spin_unlock_bh(&fastmap_lock);
 }
@@ -81,9 +84,11 @@ route4_set_fastmap(struct route4_head *head, u32 id, int iif,
 
 	/* fastmap updates must look atomic to aling id, iff, filter */
 	spin_lock_bh(&fastmap_lock);
-	head->fastmap[h].id = id;
-	head->fastmap[h].iif = iif;
-	head->fastmap[h].filter = f;
+	if (!f->dying) {
+		head->fastmap[h].id = id;
+		head->fastmap[h].iif = iif;
+		head->fastmap[h].filter = f;
+	}
 	spin_unlock_bh(&fastmap_lock);
 }
 
@@ -338,7 +343,7 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 			 * notice we unlink'd the filter so we can't get it
 			 * back in the fastmap.
 			 */
-			route4_reset_fastmap(head);
+			route4_reset_fastmap(head, f);
 
 			/* Delete it */
 			tcf_unbind_filter(tp, &f->res);
@@ -558,7 +563,7 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 		}
 	}
 
-	route4_reset_fastmap(head);
+	route4_reset_fastmap(head, fold);
 	*arg = f;
 	if (fold) {
 		tcf_unbind_filter(tp, &fold->res);

