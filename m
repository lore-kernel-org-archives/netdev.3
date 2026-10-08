Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954D305695
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498195; cv=pass; b=X94kbL8ff+EzVRsvbd86/XtEFt05izIWjdar/bV/f2o4T4LHugTK6bDUVgojMIrGCSVHBpgKHM9G9Y9ORx6nUUjb/u5Z6i8xHrPnMBOvtVjW31UglJYaqKU2kQOmqd52Zhgw9iS8q9XVDq1Gx10Bx8P0aFDlY1GstpA1tfXiGmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498195; c=relaxed/simple;
	bh=w+GdNA5P+DrEfgYC/fH9Ya+8/r8tR8bpwFXamzFHVWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfK9OXnsSzy/zrOAFgm91ZFSWDoZPpJopI4qqThHa0Kq+GVR8YJgyGl9rphpk+oKnq+Fbs6byP80e7/7XsLE6qWhVwGZGFoS8SrcnrqKDYpikyD+aNnwZx9IgE3gvFYj1ManNIP+2XUubhOYDawIOQWeALYb0oReC/mxAm5QwNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=O/IPrnXw; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="O/IPrnXw"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35115b52125so4694760eec.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791498193; cv=none;
        d=google.com; s=arc-20260327;
        b=nuZZvfJmGJUrKfL++YdypYPcGP4OE0QtLx/3tm6HVFDSwhgPN/xIDZtML37se2+KeJ
         jJGH8ejyOcS7HcYppnOWmNv3yHnrVje9rKmgKVUTK5nkfHAllbaxWOnzG4pq8B7p/GhD
         zTuPNj4ZwfwVqpB4o0hDcbgn0U2fufTSeEb8B+rOIoBOlEWlg4eRRy8oj0smhXs+vQ03
         f8u/WCtnLILRSK7fzSKTkAOHGSMpeYp5ZGJB2xrpQxnirjh2ch0heUKPU3A3vPwYaF2m
         e9TyzBwblbWsEhEXd4d+NeH7E0Brp3NH6ANey3k3KeDPLdLbtOPW7sjczthyYAD3zU2D
         x0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VSHSXGo0t4Q/EUEgBQMVKzpQrM64wVJhdXCVhdhUM/Q=;
        fh=KiSU/CNFRbAD6L+iBRAN2GHSpEALPzpMHITI12cs1lU=;
        b=I3XLm37OuB6MR1lBDUTdrLXOqhftYvW5ISz1PcB+QRGjE8ztJqjzpscXGKDSpIHAk+
         zlDIMMjEdu1P0w8Na5VncD2n/+hLFDtIfN8b7IxJAdgPz8wpBiGbcqlTMnRY279lNKld
         ZgKyj7t+bQx5Sx1rgNV7xHh/qxpk6MVhOCHvvOuLWBTyjkDiVbC6MdlqMa/ijdnJtrDR
         4pCwfGY5DQHZqrykMfvxRVfHORZe/tmkIMuimCDjMpc09a0+WoYkC562GkM5dL0cSvNj
         u1TxawQbERbvHxp1r4yi5X6/lEiDxpnD45kahchYtSIRIfRQfmbiSmmWbC6cx0Cpdg+0
         HZlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791498193; x=1792102993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VSHSXGo0t4Q/EUEgBQMVKzpQrM64wVJhdXCVhdhUM/Q=;
        b=O/IPrnXwfo3kS1UUB/IiNRZQLnXJH8WML8zKGKjCXDyFEnBfVCZCumvKpvPzFkQ9e+
         eXtiobcwxqUgXuRWLZcwBK/vGfE0vJrbU3mZ8Z6dYzGvDdkTqwxJIqXbDSb6m/eMdpzV
         OUpzGo+yIMQFdQ9N/Jxsmn/986Lc1XfQ9TVkBAQhEchmUytWyox6kUUTu/uk0z+yx2kD
         iBRLPY1QXw12KY/0xqWwUr/ii1GkztW5atdWa+LxuYEL2PVQ/jQ9SnOzPEtY3s/N3e9J
         hxs1RXoidPkBU3wa7F5Pg94uge5Jzh9tUAyWJwI4JJ/hXc2DAqZTDPW6n4wgcOqUOWhw
         yiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498193; x=1792102993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSHSXGo0t4Q/EUEgBQMVKzpQrM64wVJhdXCVhdhUM/Q=;
        b=T7Q1T1fIJY8e9BnkV9QAgR4H9b1bAs21hmcIbsskK0D5AeCObofVt2w6dHMKVmmf1G
         ROjN/SC9vaBJPTrbjuXQ3oRKAsqjQDS8/hM8cPnfpQmgpepGPkT9i/CPQ9WpMQ0Kf1/q
         C7W+QfCPUBqat4+TqojaHrqeEd2HvfKBc88xFaNXkfTlMcdJK/ZvxNoAZ8sXykwCOCU9
         6/IKiXl6ZZ9mtLeUqY/JWp/Fp25P5MRZX+Ov+ZlUiWXFYvj/dSS0Gkny5UrLoPVOE94z
         eaGZQoiCyJQMrhxk6SeDyXW6nG+ekAiL9tlZaINattBn3I7Vth3QHquCcmptx5nGcl9j
         5Iyw==
X-Gm-Message-State: AFuF++nbJADMQmZU1iSTwBD0QBu+bSTaHaRwJV6+c4toVu/fp+sKtFBX
	mjUiy1vscuSq3spJdZlkacfg/+8BK5K5x+lnI3zjUhBkW6ISYdFapU3UF4Aw1T4QLMbC235LshR
	b/Ah4oqjt4gTPkuTbuNBAayrSrSW0b29SOufued/WGA==
X-Gm-Gg: AYBFou3rlkqS7O/lnBOPHto5sAIvpckcxQO2Y+SfoK6KFbZzvU/792a25Wym/x0JT/N
	j+yd6ydpQOOpVoaw/KrKoEEZMyhTuaanK3wliZXxubBL5W2VzzgPbNAXc3pafEIhIPZVF5QK3/o
	EPIjMRMbArFMzKbpWIQ1CjJgCKzhs4y3rfLtBrKnj0U1KbYof8TJB+9T6Ucra4iASZNr2abhCFp
	hj7kXiHCjHrOCcksxK5HALUOKicxkSDZnqv8rPPxKv71ba90sDdFmGR5KzLTsNgxzjZuwIUFTKM
	fErxWmnb7gKQYmvhV0b/X9qzFsypSTlx8SCLLHTc4ovkOQ+kGH8y7K4=
X-Received: by 2002:a05:7301:1522:b0:351:6b56:6627 with SMTP id
 5a478bee46e88-3537e0f5b7bmr297127eec.40.1791498192795; Thu, 08 Oct 2026
 15:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220256.1844072-1-jkain@nuro.ai> <179149781385.2527009.3611488194198236417@kernel.org>
In-Reply-To: <179149781385.2527009.3611488194198236417@kernel.org>
From: Joseph Kain <jkain@nuro.ai>
Date: Thu, 8 Oct 2026 15:23:00 -0700
X-Gm-Features: AclHuK_Ra0QaGiegHrPWZPoYKlS9D9eX_jvak8xFNq9tYhv-FeTeUsvK1RI3pXs
Message-ID: <CA+Y90PgfrfJa2057FwbW5=9LRBOqh0EwgWW9kPqynWoFhp7-Fg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: do not let defer_count outlive an empty defer_list
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:16=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

  Manual code inspection, LLM-assisted, during a backport -- not hit in
  production.  I hit the heavy contention on sd->defer_lock in
production and had Claude Opus

  The context: an arm64 PREEMPT_RT system hit the sd->defer_lock convoy tha=
t
  844c9db7f7f5 removes, where a descheduled lock holder queued every other
  consumer of that NIC's skbs behind it. While backporting that conversion
  to 6.1 I read through the new code and found the absorbing state this
  patch fixes.


>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
