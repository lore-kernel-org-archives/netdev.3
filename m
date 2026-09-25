Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DC44AB9B
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365443; cv=none; b=U7kNFdc4I/y05YKNY20jsK6OuiRKnCpjpvqCKACOb8DmPKL2LuAdSp3GI6W4QhpHutqGl5h4sm/A+5GhLDOSBNobQZNu4uLeH3CucGLbnnMn9CGbIwaloAUClw7fz4kmObikYrc46X1r90jq0rqog3yN+IaXcSRDiLUO1QAYxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365443; c=relaxed/simple;
	bh=XLBHiYVbY4XboqeYH53a089Bs0z0CZeIc845oCpHAWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyUeytel0O31GRHrERSZIW33IdNTR5htBb+/Z+Kgf43On/QeaCcpHf47VoMVS9ZOlGNcB1y9PwTDgyHgzY4PRdi0CkbyguQeCPzmD/x3IypacbWzHcqlZwOrN+edXvuqntc9EcFYQ5E5+1bINdhEVt/fIXWO+bB5zTml7cF8IKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp3t0K5/; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp3t0K5/"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd04be84so1515479c88.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790365441; x=1790970241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZYLzW5RinpejYLZI0RBfejVj09PiRk3kGoXJkMm971A=;
        b=Xp3t0K5/1Jj3CFSXumS/lC/8YeOmOrPq5p31dpMvxmIe6fpP0HOlLEL4IIOWaM/Am/
         nNf9ns4VyEYKf9fjzawfVum0Wa4CfoK0olXqXXnmXjRYvikfUGNP9nRI/v3vyd9+9kMK
         KtShCGR0plvt1sL6Qa04e5IuSUcFn7XVmJ9nEJFVRU7U7JImsRF/14fprnwm6RFYH3y9
         VLsUaKOLpv5F+S77Ofx0XJIisdO5VOX++ZaTwJcsGu/ymCEt5YVL0tHMwm+hYl7aVOAv
         AEwOG5bB5xhwv/3KZ3MGBf/rPm25jU4fEwWwEX2B1UOkdYBpNXo64Xz3qFTK8o/3O96d
         ZNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790365441; x=1790970241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZYLzW5RinpejYLZI0RBfejVj09PiRk3kGoXJkMm971A=;
        b=j8KAxBj9+lMvRSkVDiUnge7K02xKFBPrG2pDQM51pQ7QUb9YV/fuUvVqPYu6vxnX4U
         0Yn9zUi5Gc7DcNM+d1PBR86L4g7MXXjZKataGjRZps22buriGzXajvu52ajX8SOyymKu
         h16cBNgxZ7J/CXmhYs6dLYzrEi0j8YWsUs8PH5GGPvBCLRzDZef20zTOxz4jlHblsYWB
         8roHNVlDX8LbknhNY0KvzAMu1qNJF47uzNw02EeGQPt2eVsMxVB7H/KirTsSWtJ1zLy8
         E7yEpW2V2GITxG/hM/v3RN3sg3VLOszhi05rSznKbYuCzA1/ELG399o2XMeLZfE7FXlf
         KkbA==
X-Forwarded-Encrypted: i=1; AKwUvBznT7SWxRP8kRCGyBY0tfRoIvjQ+vYYVe2F0i39apftP2UtEMiPdommAdTUb6uRDGbe3mtPbx4=@vger.kernel.org
X-Gm-Message-State: AFuF++lwW1waQwIRBRK6rF3pr8ZLLm57lDvBoVNOECQyYsy8obTX8R3g
	H85fJowP5T1NR28V7ggXQfJlBrEJB8In70lSft59vRmphVo2rsJ4GIxY
X-Gm-Gg: AYBFou1lF9uwu+AaDS/EdjJkPEmX9p+oFpH5fG9WsVCGvyk47RMCFj3prrTCc6Hmu0x
	eBfLohzu3OTEHe4OlVk2rwqeFe3+gzkyzlU6RpEkqrCaBxM6oR7ZhpbNbdhVOd0pUnbGslzp+LV
	cxZvsqnMOl3RuGWw/iTviEMoqCAVp7Jh9FwvPG4Ll9nTVrEK+TemorAe2tBcEkIfkjtUFKYCnpk
	/0Q2Lr8QjqEYrRDOy2ncg98N2DlvJuez+4MeUW3v+PnpU/xpn6DHmwmyEO2O5fcK3Huaa+7WhBe
	3/p9hL+cQkwbscyefxAua/J0SlzncBxc2nXP4QxqbXzSwjC+4eo2eVi3s10a+8v38irs53nwWbW
	zYifHikWVOu0VQP4H9lMo+NeXxD10Ps/tLrlI7X1vHoqqczH7jH2APiR3XDdNydksKkFPQeDpu6
	zNnX5gP6hBISR2lsnwrwwCg4iKOyMSPvbg2Na98N3+mEgh+8zBONPXEaqRF4dH0WY8gPbbKTU/y
	ITWO0eWZJH4E+gFSlA54AHa91MfASVO3PncZBacR3yt7/QQGt8T/7reO+i1IDqEnp1NU/DDviE=
X-Received: by 2002:a05:701b:21d3:20b0:145:123:5bfd with SMTP id a92af1059eb24-146cddbcdb0mr1091632c88.10.1790365441309;
        Fri, 25 Sep 2026 12:44:01 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:afc1:567c:4083:c0c4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c0ccsm7253008c88.4.2026.09.25.12.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:44:00 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next v8 1/3] net/sched: sch_fq_pie: add per-flow statistics via class ops
Date: Sat, 26 Sep 2026 01:13:51 +0530
Message-Id: <20260925194351.8139-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179028363994.2160803.3084881967142411218@kernel.org>
References: <179028363994.2160803.3084881967142411218@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Thank you for the review. Replies are inline below. No code changes are
planned for this patch.

> [Severity: Medium]
> Will this layout limit how both views can be extended later?
>
> type sits at offset 36 and class_stats at offset 40, so the struct is 64
> bytes. Once this is released:
>
>   - a new qdisc-level counter can only be appended after class_stats
>   - after that, struct tc_fq_pie_cl_stats can never grow again
>
> Every message also carries both views. fq_pie_dump_stats() sends 24 zero
> bytes of class stats, and fq_pie_dump_class_stats() sends nine zeroed qdisc
> counters.
>
> The sibling struct in the same header avoids this with a union:
>
> struct tc_fq_codel_xstats {
> 	__u32	type;
> 	union {
> 		struct tc_fq_codel_qd_stats qdisc_stats;
> 		struct tc_fq_codel_cl_stats class_stats;
> 	};
> };
>
> Keeping the existing offsets means type cannot go first here. Would a
> union after the discriminator still let the two views grow independently?
>
> 	__u32 type;
> 	union {
> 		struct tc_fq_pie_cl_stats class_stats;
> 		/* future qdisc extension */
> 	};
>
> The commit message gives the new size and offsets but does not mention this
> constraint.

We actually posted exactly this in an earlier round:

	__u32 type;
	union {
		struct tc_fq_pie_cl_stats class_stats;
		struct tc_fq_pie_xqd_stats xqdisc_stats;
	};

It was removed after review flagged that the qdisc-side arm
(tc_fq_pie_xqd_stats) had no concrete member yet, making it an empty
struct in a UAPI header.
We flattened class_stats to a direct member specifically to avoid that
portability problem. We're not planning to reintroduce a union now,
since there's still no concrete qdisc-only field to justify the second
arm. Once one exists, wrapping class_stats and it in an anonymous union is
straightforward and won't break anything, since everything from offset
36 onward is still unshipped.


> [Severity: Medium]
> Does this silently truncate the rate?
>
> The product is computed in 64 bits and then assigned to the __u32
> tc_fq_pie_cl_stats.avg_dq_rate, so the high bits are lost.
>
> pie_vars.avg_dq_rate holds bytes per psched tick scaled by 2^8.
> pie_process_dequeue() fills it from (dq_count << PIE_SCALE) / dtime, and
> dtime can be only a few ticks during back-to-back GSO dequeues.
>
> PSCHED_TICKS_PER_SEC is 15625000 and PIE_SCALE is 8. Any internal value
> above about 70369 (roughly 4.29e9 B/s, about 34.4 Gbit/s) wraps. For
> example, 81920 converts to 5,000,000,000 B/s but is exported as 705,032,704.
>
> The commit message says:
>
>   Widen avg_dq_rate to u64 before scaling it by PSCHED_TICKS_PER_SEC.
>
> That moves the overflow to the narrowing assignment instead of avoiding it.
> This is a new uAPI field. Could it be made __u64, or saturated at U32_MAX,
> before it is released?

We're keeping avg_dq_rate as __u32 by design, to stay consistent with
the sibling field in the older tc_pie_xstats. pie_dump_stats() in
sch_pie.c computes the exact same formula into the exact same __u32
width, with the exact same ~34.4 Gbit/s wrap ceiling, and has shipped
that way, unchanged, since the original 2014 PIE merge without this
being a reported problem. We'd rather keep the two structs consistent
with each other than introduce an asymmetry between them for one field.



