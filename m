Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3C3F8EA1
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372914; cv=pass; b=MOLfcg77AAeA26xpJhaTRR/hEwDUPZvNzXdvtqKosA413kUlqkQuQcLK1pwYIUCKOcbHs7LjsNDNXYdO31tWa7FK5RneRoHi+K3n7n6+uSd31aYKE7gTDKjWJWwpBkew9Qsxf7RKgXzE4ub0S0CSQQ7QTgx6r9JEMaP/C82IsrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372914; c=relaxed/simple;
	bh=gTzERpZlT5pEm9qhy0tz3+HBCuqqxoWXkb1wQQ+nw3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlYtS0W+RVRCfVnj4DQ6p4NCZV3tYqWuaUCm1H8zzLpg5YEmR289WwFV66VGKlK8l15qies9TvC/+BCJVjiVhABqImpxzjGLqfXCOVd4/H3e0fQuhrlRSP4I7kywLQZZPT+PyVkmk8O2ncxpPlvTrWx2lNUzu1ZccIRmN47I3cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=U6V2X7SW; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="U6V2X7SW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso1353975b3a.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372912; cv=none;
        d=google.com; s=arc-20260327;
        b=YGY53tT4/mORm8Koi5VAtLZMohwiCQ/rXTNTsOaxHLeWmwdyq9GEpma1HHlrl9fQkE
         /KVn4YXNNj12ZaMbyyEUnZfj9YXwbA09clIxi8sSk+1b9QEO7sGGEEIKDjuUFMzR1A3I
         UHN8xOuTIDexg3tsH3UXuwFW9rbpQZg2WuOz0P0+2rDyYjuxzf/vhA7ktb4YjRxouUBj
         FFUX6FTjzjqokq3sfz7ogGGHtD/szI06XOs4qzwlxw14R+B4geGQUPHVii798VafqJbo
         hEvddPo0SpICfdOG0NlAhI8NyhnwQu7C20IdDi8yB/qLBn1YJrfTiYrhYsDihsXMkmMT
         bwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LkJXFDhdwzVaI4vHWxe4E3DcB81VQH0ovvJhCbGwt+U=;
        fh=v199mbaAeQPWDMGn/jBylf836NfxFcyy4Z8lKzAIB44=;
        b=DrkU/NlpntqENzYVYSRDliwxQcoT7VoaSLSRbKuiFzUkXzrnULPTbOQtizpFiZU1ep
         kiQlJyvlveRNoQgw3giVD2VMk4kL9LKI6vyilLqddS45x6prnfxAmC0pkFmtW0ULUeJ+
         QB5t316wRODlZZhfVHgdyOLx0+HEtgmZZD80SaLRw41GDi9t5hSMnTqTMgPPWpVSs3ke
         fIzfv77sRyJaveo5vBK+SjkF0l60V3R5XPBKwv5GpSU5RzLnbgKrGw2GWyIwTznxLekc
         jdc8n8KPSDCaSHgfLeksL5cgqXqR+QiS1sYhNJNC8h7w3Gjs/Sx/ziJT7Au1eDbcmPOR
         JGjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786372912; x=1786977712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkJXFDhdwzVaI4vHWxe4E3DcB81VQH0ovvJhCbGwt+U=;
        b=U6V2X7SWJ8XH82PWLdaJQsmPG6pMy81lk25NBY0z+6G546N0jMFXlK3QcLWqwfURxX
         qsUdKYBRQiy/7cat1Ftw8GoiNOBmQeecopBk1X+KbrcyZidllo+WeZOWQvrGSTP9TwxS
         +5cGJJ7FGpPTyxweq14Sd9n3ADCk8EptVzu94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372912; x=1786977712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkJXFDhdwzVaI4vHWxe4E3DcB81VQH0ovvJhCbGwt+U=;
        b=hF8bNWoejkO6ldKlpvXkKnj1XsmF6tQOHEhuYleYi9KT4XOBqEkgGdynJPpHrMcQS2
         qq/7k5Ymg6fPPQ5/cHFWcHFZOhtmm5R6y22F11sz2HYoemGKvaa1G2tihNOVLI+8//ki
         kLm2TmMUJ9irc4IALxsmYNTBMv2fzhmCEZ6hCU2QBHl1IPmme5hmCNYW8bEi7nKNpVGH
         EgwTUUtHQK80/TqbacGbdHwSFdE1/YZxTsSwN9E5J8q2LXBXq5pin/G0dHpquA3UkWSP
         6YYWDDHCS3fSCejRnDF3BkQfGI0acIZwE58mzyZ8Uq/0bCWtYSh+iMlY6VNrowUGbhAM
         JlqA==
X-Forwarded-Encrypted: i=1; AHgh+RqeXRQ3ASV14f0RIMVxx0h2L3e/QZ26nB/gqQVL+66sXizK+EFcI9eOKB04o+quzumwJc84F5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1C9EffkJ9gXeM/xsl+NiGNqw0ApIDKneyH8rqKrAsoWnE767o
	M9Yjf4dlZsfhiDN7DWiV4xpcBQIRcoNd0IEEWgorsH+eTGpqHgaPd3wA82d1JujFLCyZoQ2NLVw
	m+lJ64P3eMn2dGe4dunP2diAUMjbSQe04POYJWyEh
X-Gm-Gg: AR+sD13g1IrhuHvqO7/xs9M9qTDQdvKCVI9DdyLs/r+1P7fCMOAQED/Bif+9NsOf1g2
	hThQzJ1UW+iDVG3TG+2GcALcqXNaaUpAn0LqpokpWO+7b2s+p4lkGIOO3cL/+78K31yO2ADqRQJ
	lWacC4W/7KSulBDGD2jEwU3XYSO4aAe8c1PTlHXlFbTL7xSIutNwWcSmbNnyN30WPAgMsUPv64a
	5+y5FB5Orb4cFCrYoSq3tnXzDv+KrI7KIYwJD+ZYFtfqbBuvkZ0fuBiNrgammBsBTrV0rR3xigi
	cFvG6D7vF6E4AxG5ll7GxgzER0a9kF8MvJ+eS8giWEoWxZOMzymXyLM+
X-Received: by 2002:a05:6a00:398d:b0:848:4ff5:5316 with SMTP id
 d2e1a72fcca58-84f4fe9f91dmr31267739b3a.19.1786372912067; Mon, 10 Aug 2026
 07:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1786089038-36366-1-git-send-email-zhangchangzhong@huawei.com>
In-Reply-To: <1786089038-36366-1-git-send-email-zhangchangzhong@huawei.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 10 Aug 2026 10:41:40 -0400
X-Gm-Features: AUfX_myBH5dRx8tXs1_g4SlvAteqoQ5KvAKBwAsm0K7OlTpbdnKoqnTqaKHWAOE
Message-ID: <CAM0EoMm01eieGx7P=PPa9=J7LnBuCufpMM0L0WmW2H6fJrQndw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_u32: skip hash tables in u32_bind_class()
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:58=E2=80=AFAM Zhang Changzhong
<zhangchangzhong@huawei.com> wrote:
>
> u32_walk() enumerates both struct tc_u_hnode and struct tc_u_knode
> through the walker callback. u32_bind_class() unconditionally casts the
> passed fh to tc_u_knode and accesses &n->res, so when fh is actually a
> tc_u_hnode, which has no tcf_result member, this results in a
> slab-out-of-bounds read of res->classid in tc_cls_bind_class().
>
> The issue can be reproduced with the following commands:
>
>     tc qdisc add dev lo root handle 1: hfsc
>     tc class add dev lo parent 1: classid 1:1 hfsc sc rate 1000kbit
>     tc filter add dev lo parent 1:1 protocol ip prio 1 u32 match u32 0 0 =
flowid 1:1
>     tc class add dev lo parent 1: classid 1:2 hfsc sc rate 2000kbit
>
> Fix this by skipping hash tables via the TC_U32_KEY(handle) check.
>

Reproduced.
The commit message would be better with what the sashikos prescribed:
example to describe the type-confusion impact accurately (wrong-field
read/write + spurious refcount, OOB read only under the tracker
config) rather than "slab-out-of-bounds read" or "OOB store".
Dont want to push for v2:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal


> Fixes: 07d79fc7d94e ("net_sched: add reverse binding for tc class")
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> ---
>  net/sched/cls_u32.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 34d25f7..90ad80b 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1250,6 +1250,9 @@ static void u32_bind_class(void *fh, u32 classid, u=
nsigned long cl, void *q,
>  {
>         struct tc_u_knode *n =3D fh;
>
> +       if (TC_U32_KEY(n->handle) =3D=3D 0)
> +               return;
> +
>         tc_cls_bind_class(classid, cl, q, &n->res, base);
>  }
>
> --
> 2.9.5
>
