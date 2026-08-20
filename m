Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866B5417355
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224203; cv=pass; b=HQmUBm51TwOCfvV//9qGcovb3rGIppDA79sH1C5IhIEaX8iVFBqooGep4j4nVT9ODliXy7DVLDcXJfNq+AFBbqpqTJVGyRiwHGGWkfMxoOyAqtv9FKsd5sOLAJhk+9o3AxYfcMClsVI57mBqVEosS8bEiwaaFjiBBTKSTR3DFWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224203; c=relaxed/simple;
	bh=UnzFxx8UR4V+EBKZrdkJLhup323hFVXO6RK4fVNl9KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8PiUq8IaQWDa1XiUb9q1Vr21WWrc55xdof3sZisnRN8vDMATQ5v+31Gn4+4ICH8IjyJLtygOFycC/OoqVEoe/NpFwrPEEaotDL6JWWMBjVWQqyihPVk3ysc9GEFEKCa/tHlXzp7jUQSUeQKI1HBRjrSwQsL+P/UXOFi/MD5BIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=dfwzJOR9; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="dfwzJOR9"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso647040b3a.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787224199; cv=none;
        d=google.com; s=arc-20260327;
        b=QlB+QJeKT7PKEEWvCA2miYqznaihJU5U9n+abIOQAQ27hc8U9JkG7j8j6WUu5ZrazY
         lkSv7YJryz56aAIqS3+vB8X6/83Qc7roxKJ1tcnRfrecpu6nLgZK6hW36iNk6Lxk4bUe
         +PzYMbB/33cIjQnwwNofKM27HP7lvCspdUV+nYzk8mPoir+oY0h4uNNMhhg5UosT+AgV
         qDwbylTs0dzRyaJVh/LvKOwuAxyUSJPuc5QBPiVUpgwQ8o+iSp/u9TPR34iP4RpUVZFW
         V3rFDRwRjj6HeGnsKPWqzmsSRvo2bBeLrmYpgmaEZ6Ifd4YwY7uAFis99hZ5v+3HYjVq
         u1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y+JX0uo36qcJTRTsK8UijWY1BkclUdQkQ8zvGF+Ak4k=;
        fh=Mo4jABy+Qqpu3ugugQfCi9Eaac8e5YZFLy7xCFbdG2c=;
        b=V4gAwsGocjLAtw7RFNatlRrO053YcJQdvHgkVX9OdFVsfieiog/nySS+id5Hd8n6tj
         nvqmNc/C9lCRMYQPJNaGNCnfKavSR0E2D2Yp4P7mJhLAvpLD8+2KCsaKceTHJCYRy8v7
         I840sXV3KvWzNwIiQvOKLUVm8pqg1dyjX51QeP90LEHfwO5YSaxLw3J6PYTuuT9sw+nT
         wIdgFhgqrapa8nB2ARsK+UsDMYO2zZz8NI1L2nVK86pbr3b+YjLMb+3Yawy77/kwiI9T
         p5aFUM+uwHpGQveG6Qs6iE5XAN8/w7KBPxbz7GDvIZ43GLGAHm6ZyuHUvp/gpPQBNVuT
         WoHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787224199; x=1787828999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+JX0uo36qcJTRTsK8UijWY1BkclUdQkQ8zvGF+Ak4k=;
        b=dfwzJOR9eU4xwnxazKvuOLovyzRB75Y/QE7GfkoujwwVO3m2FinAiC9IXVb8xjBiK/
         nXWwW+MccGMWbeG07GO/Q/WxDlUMQnJltyECSl93sR/k5MSd3z65yUzxeIGNNkwxR4uT
         Gk/7pZmYjXgxVfinQED11zN14at6rA2iX0WaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224199; x=1787828999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+JX0uo36qcJTRTsK8UijWY1BkclUdQkQ8zvGF+Ak4k=;
        b=YlS8SuonjVO7op9Zfb4oyA54FALnO4UZD64Bg+7lUcKjBgHpLbb1d9rKVB0Dg0nhbT
         uUBMCmceVvDakCj/0vKMNjTJh0EhoRKK572LOx2jqyS9ZwCGpTWckIy1Td007XpeVnjS
         uPRZJ3+MxMMk5Nwnc6TFkooSkYEI/MSoElql5nKudYyyQfE9sH0NEaZyA9UFyFR1hUSe
         hGQAnjMSYsPotM/3jAu+2B8XICqHeGJsT98Wn24MjNDgdc+lrJdCigJv8rVuP9ZZ8acG
         /q5w/bRFBK/SRLAGttEXqaDQB3qz7llZ9H7uBsECgLZo37NGp8PgdwX0HS+hi1h41hFf
         C+6w==
X-Gm-Message-State: AOJu0YyawYarAnoS6Sq3Z05le3Pb5LjqAbMK2qm84tPwROtGFqgYWhrT
	6z4ANoUolUNLI6WPYavy9MrbLTCuxdrsIEwCnZKaNDe300+3S4+wYxvxC1rQVvxKQq3cLvfaHFF
	B4FhSErOVCBK62dAdlm7Fw3N5/+7VekkV1K5j33rpDrf1l/AMIOrV2DX6
X-Gm-Gg: AR+sD11rVKB7mowMyQOSn+Aq458RQx9rI5cnZceKG3E2PMrQlX9FhWbrggl4Y2uuCgV
	TVgRBssq27f5zkquHYglpDDsAUOn4K6moI+KuHpk5PCdXDzMx3WZ7aSmaex0OTVvpXtvBHSpSOF
	lLismNz4smVWNB2Ul+pxte+0Lp11ain83QJEv9qohRzSHorILyvQw0r1qz0Ll1I4NRLM9jDf16o
	ksSDsnjtaySFZqbavmHhknVfrSL00grXqk7ynL331bOpUu9m6AQOfVrIrxw5DBP06iCTuhv6iNW
	AD5Kk1S76Q4Xs9RrgKLYKAAAXWUqoJI7yEpgbtZYnPpl6w==
X-Received: by 2002:a05:6a00:4603:b0:84e:cd14:aeba with SMTP id
 d2e1a72fcca58-851df99b345mr5940444b3a.6.1787224198860; Thu, 20 Aug 2026
 04:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819204210.23722-1-fw@strlen.de>
In-Reply-To: <20260819204210.23722-1-fw@strlen.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 07:09:47 -0400
X-Gm-Features: AcwNN1VW1bC6b63hGiY5qRNh7X0r1oy3VYDhfJ2imA7bCu4LicwS2qmysWjlTC4
Message-ID: <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Wed, Aug 19, 2026 at 4:42=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> This series removes skb <-> conntrack mapping after pedit
> altered l3 and/or l4 headers.  See patch 2 for all the details.
>
> First patch makes tdc.py work for me, second patch is the actual
> fix, third patch has test cases. Last patch also removes the mapping
> in act_nat.
>

I apologize for the delayed response in the private exchange, but let
me repeat my thoughts here...
As you said, the munging can be done by an ebpf program (at different
attachment points, not just cls/act using multiple helpers).
In your commit you say:
"Packet rewrites are still possible with BPF. However, unlike pedit,
that needs privileges in the initial namespace."
That's only true in the default setup, but with BPF "token delegation"
it no longer holds (will be reachable via unshare -Urn).

I have not tried to verify what i am claiming since we "last talked" -
but could try it out when i get time (weekend looks promising).
If what i am saying is true then you will have many places in ebpf to
fix, which is not ideal.
But even if not true, you can still do it with CAP_BPF - which leads
to the same outcome. Unless we are saying as a general rule we should
prioritize where/how we fix things based on whether they are
reproducible via 1)namespace -urn  vs 2) require root permission
(assume this includes CAP_BPF)

With that thought in mind, the question is: is there a single hook
entry point where this could be done?
Example: nf_conntrack_in() or nf_confirm() as the choke point which
catches all? i.e check the protocol consistency there and if there is
a mismatch you call nf_reset
I understand the dilemma: fixing this in both pedit and eBPF will
penalize only those hot paths as opposed to this approach which will
penalize all of contrack users with no interest in pedit/ebpf - but
otoh, I feel like this will be a good defensive mechanism for
netfilter for whichever new creative change in the kernel which could
be used to make similar changes.

I could experiment with the single choke point approach on the weekend
- let me know.

cheers,
jamal

> Florian Westphal (4):
>   selftests/tc-testing: pass mp_pm via initialiser
>   net/sched: act_pedit: drop conntrack on network/transport header change=
s
>   selftests: tc-testing: add act_ct test for ct reset handling
>   net/sched: act_nat: discard any conntrack entry post modification
>
>  net/sched/act_nat.c                           |   1 +
>  net/sched/act_pedit.c                         |  21 ++-
>  .../tc-testing/tc-tests/actions/ct.json       | 168 ++++++++++++++++++
>  tools/testing/selftests/tc-testing/tdc.py     |  27 ++-
>  4 files changed, 208 insertions(+), 9 deletions(-)
>
> --
> 2.54.0
>
