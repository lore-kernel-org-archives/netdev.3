Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3243C7C4
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444426; cv=pass; b=I5qVMfWrf96j1bcGJe9GXC0MQIIGD8alSk9XXYG0GWFsWMKtBZcfZ9Uj/GccXGOWQ9j4985uRE1VjBCbjlPbqSHrPj5K8x4JRFPomhd1c7iwAsX6AVbDDXjvL4Dr1v4kyQdkYSv4W61YEr0ithqndnGD91yUv7opXYR4YNnh0vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444426; c=relaxed/simple;
	bh=yQbZGFh0h9s7+8cS1mdgwrDyPoSg8JGPq3zFUS+Gr14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYNKidO77kFXY5vDzBWbYBpJ/lUkV/l2AgX7bx/ymv1bIKXeiTdPCFtJGEJ6JzM28QME+1Qkeu2NP48m/f9o9yvod+PAdOZJd+Sr9g7o+NO719N/1Y1LWztgWToIqMcoRA54kyorIFPCKu8vx8buadz43VCVt6XbwHGKxI9O1xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGrx/fAr; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGrx/fAr"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ed2a00f12so40180987b3.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786444422; cv=none;
        d=google.com; s=arc-20260327;
        b=gxvNGjLtwKOfQXEE/LfEkqWasC7CMfelBV5uK1aSYJHD4qg3cprcGBW1I0p1Trqh8i
         tzEeHEjrXmqT2cQ9viD4uJk9SCH9t2U5qylDQz/e8/gV64IHVH3pBPzHMX4Hl3QbwD0X
         cBTOsxh4Im8Nm6IEWoUjqKPaf9oXm5yyQLoeqg3L0tjg/ZQrhydD9mRUIE9qn7/iNyDw
         gIR64RXDLpZ9ZaSUv+ue1Ol6zyF/Z24nB4HDVcHgzIHoE9b/TLp9RuHIdf0rnJPkMjJM
         zOPlxDAGZmxlbULIcMBTjkUP63UvLr/s15XV+noO0iHiMxxUZreAZ8IwNHfiancL87+j
         3LxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yQbZGFh0h9s7+8cS1mdgwrDyPoSg8JGPq3zFUS+Gr14=;
        fh=GbTUmVvRkEfheLIZ0SbqmmrS1RCjbh+NaRrLOQLOAbs=;
        b=WEz21xfh90/hi8kigk/+tne0D/HxkpAt5NOYlK3sTVCUKrYVaAfQ1jY1A6WkbQrEst
         ApvH2x/iJWm0Psi0/rtF/U+qU4Rcxw5GoMPZ8t0vG6v32i/vUhMf38jyfI+WXKSotWV1
         VadDjW5lQbL3LxnWRElS/ggQcWv3WN9IxMVZpMUlvDMPNmfV2hSTP6T0Fj7QvYC0LXgo
         si4LMqhurC8OT0s4A9cBkJaY9QiPJDHJpDf4Kg93xcsMK97jVSZEOjAWn41TFGtdyLb8
         AD9NADYKtxsGLcwMZgJsfQ44MglzFHp9ypv5iN5VzmZ8ia6Q1GQLv1Ml0ohJAAMl0BBw
         Arfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786444422; x=1787049222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yQbZGFh0h9s7+8cS1mdgwrDyPoSg8JGPq3zFUS+Gr14=;
        b=lGrx/fArsR0myy68+zSeTtcDR4uspMMCDoopjSlGnXF+8eWec757LZSSM3zqYx/X3Y
         /z8PLGSvDiVJ88mwE53XcVnKaUPVeDY+Cjl8POLhLxDwhSntdIZ9kbIh1jLzglhOd/pg
         etQkpXdOLjMzs55fhbD/dpaJ+LhipfrxTcEk9AoVJmC4vjD0sXGh13jFpl1QY1Y+ToMw
         1Vl09kZ3KvF/xCnd9J58HsD0G+Zy31OxtpTWtXVVxFLUWAOjrdqFkm84AX5zfiWKu7Wf
         j+0fcweUFxSKuP+BWPD/k7nikMoHw/QDEVwVZ2hwPHiR+djR5z0YCtXiQsg40FfYxA3+
         4tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444422; x=1787049222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQbZGFh0h9s7+8cS1mdgwrDyPoSg8JGPq3zFUS+Gr14=;
        b=aSuj4oMch+UktnyR6YXvXpHwdhcTx52U2jtS5F66Vcy+2WcNvbbx+oCnhn0ITHIxAS
         ywosK/Rykos0VvOJFU26g1jS34dgSDiDBGGl8Q115VssvdGFRKp1Dw69zT0KpZDgt1rd
         FuEcW0s9fHhgl9uSfHBzlC7ZYR5qWm73c7xvhpar7hjXgtENUHYNe58uoBCXJdHSFjcb
         28oBiR3SrRHl34b57+9E8io+bNve9VdEpYlz6Gshag9o583kE/2vieysXRGAl8IT2J1G
         RaNtnSvnTeWnskdvIs6xnYlrv0q9CEO3oA7nnfMPY6vpFob/7UOZlwUiB9kUq3/e6T/M
         m6jQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBMfZzde+DgBQ89QzrmRAY2NQVlGfyUgA/Y6oWBZFgmFzrR4YXDwvqJOZkpMj5gU5+D+FAt84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5Io7HaaW9C607NfdPy4yadeX3nDfNmchk5sCTEmHU62YN/zl
	/mKWwX13nFBmBSq2htM27unsQwJ8Mx57l1JNec4fcuTP8v3Zu6W3KJAGrjrsfSNzrEyhXWNcQOS
	7Rc8E24nGL+tYIUtI+i85Zu7Sh7q/LDTYFk5kBg0=
X-Gm-Gg: AR+sD13kMsccJlE5frA5UFHzP1jzDFJqF1ru9B7i1F98AM6JALWkWkGLxQ1rYrbJYMd
	uOVbZJPP6Dd0uxV8egDORZrM7+5ssWc35QKN2goWY20WtaaUSHHoYI5JPochpzj64hAADvJ3Hih
	1tBPOAGWIOQiKX6gflAHBC2h8YZm1e9F3g7Wt1ky6NdXeZwCqzLfz4RbkpaOOLjCD16NwOLK+g/
	NAHg6eacnguW7BDWs1PKyaMRwqXUAunCI8owqhzR71eFnke+e90rPEGspJ9LvIudje1UKcDkpTq
	3LCfp/GFlBkebOctcu3RjjqUDAkq7n1uY8tdxz+B9XRA
X-Received: by 2002:a05:690c:3683:b0:820:1014:526a with SMTP id
 00721157ae682-82f2df88113mr15247657b3.29.1786444422303; Tue, 11 Aug 2026
 03:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANE+tVp8_NhE+KL6ZNPGjaGMLPxrCWw_A5sY0jotrvThB6idXg@mail.gmail.com>
 <anr3YZJrnS_2RbEp@strlen.de>
In-Reply-To: <anr3YZJrnS_2RbEp@strlen.de>
From: Wei Fang <void0red@gmail.com>
Date: Tue, 11 Aug 2026 18:33:29 +0800
X-Gm-Features: AUfX_mx0_SQIjUQgBGSgpUeg4ronIV04joJHHqMJFuc0qvjB6Nvhk6ftzvg81xI
Message-ID: <CANE+tVr69qqyreBbWWk_2FqpMfQAqde-JF=weECditGJF=uZ3g@mail.gmail.com>
Subject: Re: [nf_tables] pipapo: inserting an interval that strictly contains
 an existing one is accepted; rbtree rejects the same insert
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, k.chen@smail.nju.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maybe I=E2=80=99ve made a mistake?
I thought the behaviors of these two backends would be consistent.


On Tue, Aug 11, 2026 at 6:20=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Wei Fang <void0red@gmail.com> wrote:
> > -------------------
> > expected: both backends reject the overlapping insert (-EEXIST)
>
> Why?
