Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1DE488211
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283577; cv=none; b=Iz/DeXnPcq67oEyx59ywFS28PkQ75Sj6kybuPY4PGPnKuumjh3uO3C6IUSdvrlwtQb3txaZBUD7LZa8bZmY/bw1EIqKhsxmVACSIXCsgxwUxkwzx0hNLlHMkdLLL2btsjrGsZdnxkq+2vEJKu+VEZJlrKVuIvgMSELgmCVgzkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283577; c=relaxed/simple;
	bh=Wpb4O6T/xyA+5eJiRg7lEIMxsNKuDpjIIJqJ6MLZCK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hb/8PVF29XL52XGKdR/XK0FM0EZYMyHyqGlguzXsP+CbrtvRmJRTikZe8941HTPLvcMrK7neycoipBfbjx+NSDrL4rudy4AuNSXMeC1rpVjbRVPABR4vDJWymvkWnoCSVxm0iX7kraWr1rkSV7zyVSaiftHuR7cN0Od7OGNAO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayImy4gS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayImy4gS"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso125725a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788283576; x=1788888376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wpb4O6T/xyA+5eJiRg7lEIMxsNKuDpjIIJqJ6MLZCK0=;
        b=ayImy4gS60tAKn5zDNGMxB+uyyQEGmwPuhuIAnQOGhfpEcUjaeo7HWUgxbfk4C9nwO
         o2KYNKwkNuaIJ8L+mlhY7QgIhBGbFGeM05x10FZk4zuENKjyNuzHBg9Ko2hnaMN8w2Lc
         7H/ny9b/CJ2SL4PLdlYTt+4UzxYrKovuO+FmqN0MovQR+slyE9GDUzdLxEYHlo6/cCVQ
         Vhr51RbMH9BBbrTIjNK8amAARvfvp0wpHldLP8nm8yJ7apEOmEvgUaV/hytNsTkqmHXl
         VzgelCIraNrKPpSwV4uPxv0nsvqS0AcP3PctfzCgyyGHxDGxyhWgxyNPmFKlmg/3N6Ch
         mBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788283576; x=1788888376;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wpb4O6T/xyA+5eJiRg7lEIMxsNKuDpjIIJqJ6MLZCK0=;
        b=Lfv7p3TVWZBSogUMx4ol14k5MdvdeN8dJ4x8zwyc7mJRN4ZyJJj5f+UFDdU83Fgzsi
         ipQrJo1DriCmrBcVz5GqtcNK4QIRZoMxI4ibyr8otMcEnGNNJX/9GZ8+eiFizoeFgyhQ
         kVNvxAPTiO9w5teOfUvedVaqFwE56X1pwN60ikDcz7xTzhs/5Tq3h2nCl56tHkjJgfDO
         pD8AE1F9RhFUEHKwR3ymYDy8wcxiB1N8Ri/uV1JCDk1ATzi1kQ9VuEJb+DV1xQb+WufY
         7aIDE3MixVtTaHEsj8hjGpAo3J+F1+0E8ItdwgblhlHgsUA0cmTofNNCWfY8WQ7LYXxA
         W0FQ==
X-Forwarded-Encrypted: i=1; AKwUvByno0/aA5NU1cD8RrrjM9CAHPx8TcSfp6lGd74Ji/2v/gi9K34enPjW3L8EUBBoguNjpksBcHA=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ+W1sQ48WBtfXmJEKcOsH1MqYPwm5gv36ZJugkujSDDfX5Hhj
	4Hjn2W+YXTInjO3kuYKbj298T+kt4LOMdZ3rtwPTXL7/Lcy7mH7NKS0C
X-Gm-Gg: AYBFou1CDQtya0gbV8dnVBgPQ4FYzYwoRrPRSBf1k0UrWptgaPg162QW1IHQyN1sEgU
	83Jfb78i5eQs/Rfxw7BQ7LqapiPVJOMQVyHRZaSJ/sZykxZN3c4Ds2uq6F1ILlU6rUr+4zzOV0Q
	OFsmeA3AjWxD7/FbQ/K96zVuffeCxv7+R5bwryykhq7z0Nhqbj4QtlmZSV4Sr4QjItp3vTtZlSQ
	Mf7hVTQMiaWJm0vE4DLvQXHEUOU8gITm5AKuV22WBkUi43mn2JFn6Sam2JCAKcR+JEgKFMzKdP2
	H8iQo0jZ4iJVK+Zfp0WEz2MAHPEgTZJixeS3gf3LBgW50EW0pFzk8dlHJt5NeQhFL5NDmh3hfCS
	5oEEql+xZbaoTvHyiPFCc65UxIQjCZYaSpBx3Cs9wSLojnsT+TnR/8qK0t/IKHHfzQGRMFo+Q0W
	qw6dXO6gAOaZbKY7LWDOykQrujS5IAKa/I8Ezab1G8Z827ICtu3lGCbtSrfZezWB9BnmGcTx91q
	UULYz0z9uNBgWMGJSIog/YmaUtrhyfizYaM0THb8qWjf9DEBdQOOYgS5wkX2Ut9TvA=
X-Received: by 2002:a17:90b:4a02:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39907ab0960mr12275784a91.2.1788283575571;
        Tue, 01 Sep 2026 10:26:15 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:246e:2cba:1e3e:e617])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430ea0b459sm158262c88.5.2026.09.01.10.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:26:15 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
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
Subject: Re: [PATCH net-next v4 1/3] net/sched: sch_fq_pie: add per-flow statistics via class ops
Date: Tue,  1 Sep 2026 22:55:24 +0530
Message-Id: <20260901172524.39650-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731095635.GG51943@horms.kernel.org>
References: <20260727164056.106203-1-hemendranaik@gmail.com> <20260727164056.106203-2-hemendranaik@gmail.com> <20260731095635.GG51943@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Simon,

Thanks for the review and for the Sashiko pointer. We have been through
all six findings and are working on v5. For each item below, a short note
on what was raised, then what we plan to do:

(1) [High] Filter attachment and TC_ACT_CONSUMED — Sashiko noted that
adding cl_ops with .tcf_block would let users attach tc filters to fq_pie
for the first time, but fq_pie_classify() has no TC_ACT_CONSUMED case
(risk of double-free if an action like ct consumes the skb).

We will remove .tcf_block, .bind_tcf, and .unbind_tcf from cl_ops.
We only need walk/dump for tc -s class show; filter attach to fq_pie
should stay disabled as before v1.

(2) [Medium] tc_fq_pie_xstats layout — Sashiko asked whether appending
type/class fields after the nine qdisc counters breaks userspace, compared
to fq_codel's type-first union layout.

We plan no struct change. fq_pie already shipped a flat 36-byte struct;
we will keep appending after those counters so old tc binaries keep
working. Class stats still need the matching iproute2 update.

(3) [Low] Empty tc_fq_pie_xqd_stats placeholder — Sashiko flagged the
empty placeholder struct and unused union arm in pkt_sched.h.

We will remove the placeholder and the union; class_stats will be a
direct member.

(4) [Low] Class handle at flows 65536 — Sashiko noted that with
flows_cnt == 65536, fq_pie_dump_class() uses TC_H_MIN(cl) and the last
flow's handle wraps to minor 0 in userspace.

We will cap flows at 65535 in fq_pie_change() and update selftest 83be
to expect flows 65536 to fail.

(5) [Medium] Selftest case 83c0 — Sashiko noted v4 used matchCount 0
with no traffic, so the test passes even without class ops and never
checks per-flow stats output.

We will rewrite 83c0 with real traffic (TBF + fq_pie, ping on $DUMMY)
and matchCount 1 on tc -s class show (prob/delay/deficit).

(6) [Low] tools/ UAPI mirror — Sashiko noted patch 3/3 also touched
tools/include/uapi/linux/pkt_sched.h, but that copy is already stale in
layout; comment-only edits there do not help.

We will drop the tools/include hunk from patch 3/3 and touch only
include/uapi/linux/pkt_sched.h there.

We will post v5 with these changes once ready.

Thanks,
Hemendra
