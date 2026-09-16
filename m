Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A74E1C68
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584093; cv=none; b=YCrgEYCzDfjlDpOVmRDj/GptyuUjlxC+58kB6+eEhWlf/k3sqYhz1fCvnZ6iQ1HIGSdyD5CePlmAOCF6BHkimijsOC1yyOMbM3UNub3W93pLY4VsCoUFCcOUjutSgpkXu3fhVdPQwv/EbGdhaGSXFt52Rn+m8eKcNI8xGe4H1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584093; c=relaxed/simple;
	bh=nD19l9ui3ugj09Kn2ntUmpgOIMZuNqGRrXANeBNeDt0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=grKTv/GCCZSYCo8hVFfM4JWYXYJ1MaYSZCfwz+rkAib781PZK1oZvKAYtWxydwZ6V6OLuIx7lpQwNOSUZPSPh3Dh/4jUmb4nnXdq9Zk1ZQvr4+Y9LrFPV2BA4S7vi4doxTxpB6xeiOof8eRpLTHRb/7ezNyRs2t1h6/aM5stLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ISs63udk; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ISs63udk"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f6so294785ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789584065; x=1790188865; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ySn/+Nvc9slP/rzUIJxTWg/38szPYmoWWFQbtHmYKY=;
        b=ISs63udk4CcgV/o+C1iZFqcn0kDJBnvV8CD78ft7fmnafFytePsTnbjeyRqvEJIi9A
         ZSM1mfhpFYtXEwfE61h/6TL72NLFTYCo9vM8p6GC2zbYemjqXLUhCft2mjlV75DUREN5
         FD/ZP+X8e4UVbpEPPERs0w5jY4vj2GegWCCRA5cs3ms08bV8S7pgdO1qAL71Y8qZP/9h
         zHEsCo9uNGh6EnXc7x3fBQFNG8RZHf0PH7Y9hbY7cLmDlqMzqhRswe5+BxZwZwYZERTO
         iF0e+xqT5jXCxCI6FCKQmp1hK7pT6zGejC+5eSOdr+XgvZ81kWcdjlLDZM+PZC+WsSvW
         /dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789584065; x=1790188865;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ySn/+Nvc9slP/rzUIJxTWg/38szPYmoWWFQbtHmYKY=;
        b=T/Uqsb33D6d6Ra1YiYAq8D1/cwnfjp244EDiXyAktETcc73zd/cLGzaAk/JlQxoUCL
         O2Sdc8m1s68JNH+sdZIWcnCWgcchS8KfDlKU4qzFb1nQ6Xibh1VTZ6ZCVSFs7Vf1ozL8
         FcU3pYOGPbYhEh7CIcRmqOa5jhg1eXmUZybr6PT0HRYHDrkzh/6a8k34bRrmUVK+Xsl+
         cOSmRDZ4HpRfWBuCmY9aZypIM3rzGYTUSo7Vz+1XgjNr5MoL5rzL+FZOdWmXoQmc7QAW
         7+6vAPZ5x6gV14VRIg4Thl/coFTinTxFa6ELcIvkvNxLPDfmQkfasYyORTuPs75+4FQf
         tk1g==
X-Forwarded-Encrypted: i=1; AKwUvBxB/EcmZy8s3Km4WD9orR4Y6nY/yEuc1CW2C0nO6LY6vJKlUmknd2qjK4pjutiKptICN498Tno=@vger.kernel.org
X-Gm-Message-State: AFuF++kOmC/Pagg4vmv1AtXSe4YKeQzcYIjNQN9U6r4nRh4oKsNHhUkB
	7YSlZfduQ/5LgpMENJMG0qk3pngXFERL8U5Fz2fC2P/Ti5W037IOKnoRqrfZFs3V4gw=
X-Gm-Gg: AYBFou1hmoSOgNT1rGlZaCaDMAMIJdrL1TR3jcrxDZeY2P0pbgT/Bc3R8QuQY1taoEG
	Gz5wWhuzqtBQiPVzfsZ1T+BHGV7PO6mcfRQPwZIba0X5s7spbN6g6GsPgL43isr4Eagqb7jN8js
	8aWI9owVO6wIoUzD7N/oJ6RBcwi1SzKdOIFxsqwXLg006XnlK/kOuvbNDl5pF0H1uh/+vqe4BJi
	91zeLit0TwIOqAj9vvTAzvGPCvi+jKOOpzuDm4vDTgx2o4qG/TVgmdOY8BtE34/zED7rYOFIB6n
	SKRPgFDylau4XKJrFc/Gn0l7XVgYOE4JO2vlb0k6akP8oEJBKs+enRtoVviDNeK5cdiyxu/MSt2
	ru/zCQ0kuJEn9j3b806uWrXtiENICePSFmonZR/BwvYtRJTVE6LUdU0uKLJoNNEc1SE2pFcmF+o
	S5+DXoVWx38dhcwr6q3RX9H0o1fMLnPiK7uTJgyI6MXPhRusRzEOcTnoxmNPCtd9VAdokciEWxi
	W31XDnxUvWunXgVEcsbT40bQxc+
X-Received: by 2002:a17:903:1847:b0:2dd:792b:302 with SMTP id d9443c01a7336-2dd8e404f57mr94153475ad.11.1789584064792;
        Wed, 16 Sep 2026 11:41:04 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89e92f07sm16378015ad.28.2026.09.16.11.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 11:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 18:41:03 +0000
Message-Id: <DLGYLT5UIFDA.38RG9UBZNYI58@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>,
 <netdev@vger.kernel.org>, "Nicholas Carlini" <nicholas@carlini.com>, "Mahe
 Tardy" <mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf 05/11] bpf: Reject pkt arguments in mutating
 subprogs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260916050830.8774-1-emil@etsalapatis.com>
 <20260916050830.8774-6-emil@etsalapatis.com>
 <CAMB2axOAut_9utesiV9mG40bskrDscu+Gu9FUMNRKZC+hbd8UQ@mail.gmail.com>
In-Reply-To: <CAMB2axOAut_9utesiV9mG40bskrDscu+Gu9FUMNRKZC+hbd8UQ@mail.gmail.com>

On Wed Sep 16, 2026 at 5:57 AM UTC, Amery Hung wrote:
> On Tue, Sep 15, 2026 at 10:10=E2=80=AFPM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
>>
>> The verifier tracks changes in how PTR_TO_PACKET registers'
>> bounds are modified across subprog boundaries. PTR_TO_PACKET
>> registers are actually passed as PTR_TO_MEM, which is assumed
>> valid for the entire call. This is not the case with packet memory,
>> where a pskb_* call may invalidate its memory region.
>>
>> Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
>> may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
>> because we would also need to somehow pass the PTR_TO_PACKET_META
>> or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
>> the pointer in the subprog as PTR_TO_MEM, only permit it if the
>> subprog is guaranteed not to mutate the packet.
>
> CC Mahe.
>
> Hi Emil,
>
> There is a related but separate issue [1] addressed by 8fe994c80af2
> (=E2=80=9Cbpf: Consolidate function call pkt_access validation=E2=80=9D).=
 I think a
> long-term solution could be supporting ARG_PTR_TO_PACKET for global
> subprograms. For example:
>
> int parse_something(struct __sk_buff *skb, __u16 off,
>                     char *data_start __arg_packet, ...);
>
> The verifier could require a real PTR_TO_PACKET at the call site and
> verify the global subprogram with a real PTR_TO_PACKET, rather than
> converting it to PTR_TO_MEM. This would preserve packet access rules,
> allow reads from cgroup_skb programs while rejecting writes in the
> callee, and automatically invalidate the argument after calls such as
> bpf_skb_pull_data().
>

Hi Amery,

    that makes sense to me, especially since this is a feature expected
by existing programs. The main issue I see is that since we want to be able
to pass it with subprogs we need to find a way to annotate its current size
(maybe passing it as a __sz that is checked by the verifier to be <=3D the
range - off of the pointer in the caller?)

> [1] https://lore.kernel.org/bpf/aqkhifLvyAhw66jg@gmail.com/#t
>
>>
>> Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
>> Reported-by: Nicholas Carlini <nicholas@carlini.com>
>> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  kernel/bpf/verifier.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6c6b8d852..507bc14b4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10375,6 +10375,16 @@ static int btf_check_func_arg_match(struct bpf_=
verifier_env *env, int subprog,
>>                         if (check_mem_reg(env, reg, argno, arg->mem_size=
, BPF_READ | BPF_WRITE, NULL,
>>                                           NULL))
>>                                 return -EINVAL;
>> +                       /*
>> +                        * PTR_TO_PACKET get passed as PTR_TO_MEM, preve=
nting
>> +                        * us from adjusting bounds tracking info.
>> +                        */
>> +                       if ((reg_is_pkt_pointer_any(reg) || reg_is_dynpt=
r_slice_pkt(reg)) &&
>> +                           sub->changes_pkt_data) {
>> +                               bpf_log(log, "%s is a packet pointer, bu=
t func#%d may change packet data\n",
>> +                                               reg_arg_name(env, argno)=
, subprog);
>> +                               return -EINVAL;
>> +                       }
>>                         if (!(arg->arg_type & PTR_MAYBE_NULL) &&
>>                             (type_may_be_null(reg->type) || bpf_register=
_is_null(reg))) {
>>                                 bpf_log(log, "%s is expected to be non-N=
ULL\n",
>> --
>> 2.54.0
>>
>>

