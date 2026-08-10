Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B139EF2A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370400; cv=pass; b=un7jQ/LII5TYeWDhsl17IkubDXJ9o8HLJWeRMeE4zzI1rK3vJVnk9b5G/ytwRdGFaJ9Dz0OrdDLKmeKkff4ffVNHKZZbeQUhkTkeLh4NxEfIH13JZm5ZxEYuA67wdVaO98Pq1j8OiZe4LDKwv7cLltMSpSLiBpFJT6/L567+/T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370400; c=relaxed/simple;
	bh=216somtno/5OJTGWhEpg7rNFOlcyGSpXRqRobuTtA68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECrPmSUAo0lZ/XzZ6/BIcwP/bTI3TK7tmIKnNEy4WTTdfR9cZ2rstWyR+iIDUZIlkxcYrEznU4VdRUdLgcO9hbqWisD/z0uM4e7tcIk7+Zy3LbDFDVkf1vV/bI4yklznIV5pqYM/WsLgf6DNOhkBOvTHrIKUhvdl3OsHFUB/3n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WIpzMfKS; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WIpzMfKS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84874b52eabso2421478b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370398; cv=none;
        d=google.com; s=arc-20260327;
        b=okf6EAsg8cHRSMXzA7iSkbHg7jT5ZCrBoptucFOpOVuU7IZLLIiCtbeu+I0AulJOI2
         wE2d5FtkiqfX4aIufwYp5RUVmE9WFiabxavHJXi6GDKik8LrYywCDZylacEpN3XWqEiA
         TzoNHTy+K7c+2/m42X0Li4w2jwuvpXin56XMqU2PI7WRfH4rUvPkspftghU1AUcVR41C
         0k4bEBw2maFsI1jb233VZXna2WI8WHabxqTvKbY9sWJ4z8SOjyvMEQeJ6P0WTXaAyJ24
         TaP7w6VHn1qhYFsJG5rCrsUOrd4NyQZr2H77GZzWZ51YLFAPr5hc6xCrICvytElUAJY0
         qSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
        fh=RhkXHQa/3HGSPk2QgG9eCLunyg1AkwIlxRB67aVbxOI=;
        b=srvAe3an/c3fqKfcHvTJwvDMEbfeUWvoQpp+jh76x+dbmujY+zdftp3IXLB0RtmSPh
         FhgzckFtLoYPY3Ru3upBxHYLV0H1YSbHg27+sT+SrrkoxYUF1e4ub5RE15/VF6cz7sl6
         imx/R3Qy7XVEo2M2YyBiWukjtn9y5SJ1lgUi8xGEIE9dvF/za35bg3uOGqwstOzrIXN/
         ixjlzoE2uDvn9R5oVMJjkKmtMN7mZcr8NosMfecnfThKsI1sukEEpT+EQ/W2HbhsrW2W
         g3JP43T+eytvI024oeFAR8zu6GHBGubgnPgjOXS97tT677hDMmnnLJKCwSjAo5/2sIh/
         UHZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786370398; x=1786975198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
        b=WIpzMfKS41Bd2KwJvSnf2Kul1IzSHVyXDZxgAwtObaTuMn3n27wMtJaoo5GSotIk3x
         3kptEWPGePpo/cPlF0fzOF7S/2myVQ+2QNZYE2chaXgcFaYXXDczU5FBKFKOMCNFgXdN
         b1Q4o4rSgQyfTn5HRXBAfrB/8RDIp7ldl0PmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370398; x=1786975198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
        b=IiKLXzalBzmoflv9YWL3KfMOUw+eho9Qqu1vnVeLB9y2PEjaoq/1ve2+TymOcGRF/y
         aUgvrnj/7pUgIJjh7X7RyvPw/Dwy/8J1ZU6NVme+PQy1GqG1SHR8bAEKVd466deQeWKm
         3L44eVc6sxUe2w899Kui1v8Ij5vfNRyqcoq2gFSY3GiOdE0qVQ1pE+WbkbqbHHi6b56C
         +NldjtOiqcE3ehT7jva8MhtmjtKXl/lV7p0tz/U0uFOx2MedM/wx/vMppRUisHMuyjm2
         +3zrxLece1/ax+U3A/Z8TP4trTHh9qYSBCuHpn53iUTmR8z3IrtJadGfln3znlY8uFu0
         45sQ==
X-Gm-Message-State: AOJu0Yw0UejK6udm/cmdEllUXdXFYtN4LZlILm5LM05suTFyi7iY5XT4
	WYq/NQVtXjX+IBqqVp5COrLRB2iKCoamKHeYmpRPV2n/PuqA1RCCa1DbElb124fwcZ2IPSyc0pE
	yiumSpJh8fe8FsOUTxg9HlScfcVUHoCQ/JlzjzQza
X-Gm-Gg: AR+sD129gxQY/3HM/fA5eaXSFx72nuoNTBCqqJ0EvzgjX1NRY2JatX9SKBFVJV6xVx1
	wySlXZ0YVP/KTWzAG4aQnoguJhjw3D8Af2DTKGr7fiGZ9ew5hS8N/O+FSoFJywTzpnjnuBPU6hB
	m9MVSIO9TDMLJ7yPYSXudY5A2RIhNs3mVwcf1OFB5QZCjJUEkmittQ2/dTC/h0HjD8Oase10k5p
	cW4NEduqYqi5sfZp0uvMGzhqcKLXgnY2h9C4dLMzG6od9IzzWERyXMD3kyURvTNfQX+XjTzAwuM
	tLi6fEbd9Qep0nFYooCo1bkkhCNwXKCpv3fa1ZqynaEZFQ==
X-Received: by 2002:a05:6a00:3310:b0:848:5540:2377 with SMTP id
 d2e1a72fcca58-84f5dfbad07mr26834874b3a.17.1786370397896; Mon, 10 Aug 2026
 06:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 10 Aug 2026 09:59:46 -0400
X-Gm-Features: AUfX_mxRG5jLc08nNMpM49kTVM0uIbxQQVBUXgRTCxaHxX5AM-qtREHzLHaaOE4
Message-ID: <CAM0EoM=L4LBAnyxf+NG1D_dY2nre8fKgVxoycXK=sY-9Ruc9+w@mail.gmail.com>
Subject: Re: [PATCH net v1] net/sched: cls_u32: feed u32_replace_hw_knode()
 with correct set of flags
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	anthony.l.nguyen@intel.com, kuba@kernel.org, jiri@resnulli.us, 
	edumazet@google.com, stable@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Marcin Szycik <marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 7, 2026 at 6:23=E2=80=AFAM Jedrzej Jagielski
<jedrzej.jagielski@intel.com> wrote:
>
> Fix u32_change() to pass proper variable to u32_replace_hw_knode().
>
> When trying to offload u32 cmd by adding skip_sw attributes it gets
> ignored and it cannot be correctly processed by HW and tc_cls_u32_offload
> struct which is then passed to driver lacks skip_sw var enabled.
>
> u32_replace_hw_knode is fed with the TCA_ACT_* flags (bits 16+)
> instead of TCA_CLS_* flags (bits 0-4) which actually stores the flags
> parsed by tc, so tc_skip_sw() always returns false. This leads to
> ignoring some of the attibutes which are meant to be configured on filter
> setup.
>
> None of the TCA_ACT_FLAGS_* is actually used within
> u32_replace_hw_knode(), so there is no point in passing them.
>
> Looks like commit 695176bfe5de ("net_sched: refactor TC action init API")
> shadowed the local flags variable which used to be set with
> nla_get_u32(tb[TCA_U32_FLAGS]) with the flags as the new function param
> while not replacing for none of the u32_replace_hw_knode() calls.
>

The sashiko reviews look legit to me. Mainly: your change makes
u32_replace_hw_knode() able to fail for the first time (with the
action flags it always returned 0), which turns three previously-dead
error paths into reachable bugs.
So IMO, this needs a v2.
Suggestions for v2 from the sashiskos (I typically suck at these
summaries, so may miss something):
- Release n->ht_down on the create-path error (e.g. drop the reference
explicitly before kfree(n), or reuse __u32_destroy_key()).
- Consider switching the update path to tc_setup_cb_replace() (as
cls_bpf's cls_bpf_offload_cmd does) so old/new flags and in_hw_count
are accounted for correctly, and the old rule is re-installed on
failure.
- Mention in the commit message that skip_sw add/replace commands that
used to succeed (and were silently skipped by u32_classify()) will now
return -EOPNOTSUPP or -EINVAL when the block/driver cannot offload.

Also seems worth Cc: stable backport.

cheers,
jamal




> Fixes: 695176bfe5de ("net_sched: refactor TC action init API")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  net/sched/cls_u32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 8f30cc82181d..dc6e455e64ec 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -935,7 +935,7 @@ static int u32_change(struct net *net, struct sk_buff=
 *in_skb,
>
>                 u32_bind_filter(tp, new, base, tb);
>
> -               err =3D u32_replace_hw_knode(tp, new, flags, extack);
> +               err =3D u32_replace_hw_knode(tp, new, userflags, extack);
>                 if (err) {
>                         u32_unbind_filter(tp, new, tb);
>
> @@ -1161,7 +1161,7 @@ static int u32_change(struct net *net, struct sk_bu=
ff *in_skb,
>                 struct tc_u_knode __rcu **ins;
>                 struct tc_u_knode *pins;
>
> -               err =3D u32_replace_hw_knode(tp, n, flags, extack);
> +               err =3D u32_replace_hw_knode(tp, n, userflags, extack);
>                 if (err)
>                         goto errunbind;
>
> --
> 2.31.1
>
