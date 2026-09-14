Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E83D810F
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425347; cv=pass; b=gidsjI+zfjBjzK8jUI1RwnFpJBGSUKZYzPVQZ0iWads54YCSHAQ3zNRW8JLph7Ffafj8Ppu5R/+h+RbW+ZwTC3m6wlVFmBhvIm2jZirFKRzA5omBZd1lhrr2c+xgpAySQEvDitJfee0oyFh+NslU5w7eQpJtmJkOkQg8Zlqc5co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425347; c=relaxed/simple;
	bh=mMH1ijQVK/BHrqtJkvFNFIAYi7VmNkP+j6GhBHqzUEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjneZ+cl/ctCs6Yi2lH97ncM4UUP/I06zlbonNuNqJcnq2gRFT3jusMC/cTmHixPyX7lYgdmYXpIC5FIgmUYzBULRPI7FJBDk62FranOwCTtLkxUZ7LEKF0xNyFJBFc6U7ZT+K24i9IdwmvuB8oLrI5t10wDFuw6ZP3MVWf37vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=V81Xlc/N; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="V81Xlc/N"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so2028472d50.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789425344; cv=none;
        d=google.com; s=arc-20260327;
        b=LM6gpmiAwhAQhZNzGWgvkj60SuOUkyFYKxypOdXBhuLD5kftdnX83ORwTlGyknix54
         UF+oLYsuM5Qr9AYGGK/KVrelBiOpNRT+Oqs1KLb1fP+ztfYaASC3aaqZn44gfvm/DMzS
         0NYAHxWXZsWVvOS/YyHkT76kk/u9/14g013qP4/qgK4S8EssZc+gKrm5fW70g5PIdBqj
         QM/2tL5u7Bb3NtX3r0Xm0zLdOwxnIoTpqtPSSkbwyDB2hmn0acriEgA+U6a8gn5BSyrK
         Ddx4/UL7T7J0TMUioTF0x/MHdGKTJCNjHlV1yHzkiVNZNymFcF7TCQkA8ZPq06ADV5Fb
         KKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6f+ibT+gH2nKFJxetkwt2/sBz4ITIBK8m+P62pM4ISU=;
        fh=vJ2YnuGnCSyPGnUYWsFOWpTlbS8lx393q2Je6qU0khk=;
        b=N1yrSye+VbS8xpNSFg7lhNbf1LODj/8uWG3+OcaL14x6R6731OHhBBuuqq+kmBeQCL
         2P13i8xsyiZjqoup56W0UJI1ZVcmQZWotmrOlLZ0aCWOSXnc/POdgzzi1EWW94ygvonb
         Q8OLiZZ5HfxZO+OXPIlCxoj9kq2eZE6juF7fx8DVpxpUn3WhNZXoj1DejtHrykE1L/pq
         bbeAsfZlZ9SwsP/9+8FL/ICkSK3zICK/GqaY3gjTCmy6QtIXfWakn+c5TDB1IYsZwquz
         eEKFdxi+mDQ6c0l1nqlo+B/EsQ/9XowJSSpxs+tSG4gvalB/5RlCgPtekL0j/nwKLBrI
         MUhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789425344; x=1790030144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6f+ibT+gH2nKFJxetkwt2/sBz4ITIBK8m+P62pM4ISU=;
        b=V81Xlc/NWPaz+8j708oFZ9Cwx3qobsfk4X0e+skD6d3IRwC7bJfAxTzG4K5+ByfVk/
         Flve/duxMycoxsxG6QbdkG5mv4gPHGwdKhZKoiswuE5aIL6iAn3Hgn9xMkS3br9vPcY7
         o/hJZaZlE9t1HqFCC61BShbV2SxzlxU+7Rf4C99ci/+nwVBaYib0x5XRlH+7qqj1Ak9z
         GA0Bf9TqZoieWauQrIheOyVUp77RGxLxYaP3skq0kpPzZMIqrNUCsKBSvJVR1uafl7I8
         F28c+e4pNNKhAFRUwlbTlgBQndPwL9UJ/YyzB4sHEWY9hiBDMH0bi7hBW/zi9CxQIKzS
         tceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425344; x=1790030144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6f+ibT+gH2nKFJxetkwt2/sBz4ITIBK8m+P62pM4ISU=;
        b=jgpyzoB5INsKTMTd1YbXPoAUe3rNU/KfgHkDZ/TieUSGrZpOHnDSs8ISdoArCqleXi
         G5ETAdtRk5ECMUc6SpGbJm6FOwtSi/zTU12PJQKQmk3UMyaZvJtDJxokNdaFhLk8hDzN
         GOltFAGznnwss384Ksl42VP6Xm2/Ils171phRN6FQI3Tk7X2dKC8PPuxsx6vo/ZMhAdJ
         l4ZvtT4N6YdLu7Mj7AMFsO0bAcblT2IPvgkGTtYxInYPSdlz0C6uu6ClgoJUZNFmH8LS
         eNsoJNliCsk++MpktJCLdKqniR1ihbY+XA1X2x3Egoy1Lp+QHpLXV9WUE9RzqC3q6pHm
         uPsQ==
X-Gm-Message-State: AFuF++mHbW6fRf2ihPKpvFmgirD7A8jD1UvoMhPAdJNRT+Q8J4NXwVkv
	DnLKCSMeNRLI5n7LLm/hioIe4dS4HpdRkFaJPSL/siTFGKDILHNrmTQ5qvtGa6OSxCrgaGax6YN
	gbeJq655fgYl0ecoWyxDs6RRqhgGPCBdK53qFYxV+4g==
X-Gm-Gg: AYBFou2B4Gw6Py18eyLI0pa0TeAZ94raTbxSWLweZpuHAqumd5R4WMlFj6nhlwRcbNs
	/NQdt+vZoUrFWDh0VtuYcTXqQH1GvnlsIcjnH3swNV6NiytEEJql55skJKm/BRytFdMPcYHsBFA
	Ijg4B2joFGVDaMDpgsTS3Z4VZ84l6LSF4QaTKpfb70IPQkUAPMLqxvZWBnnYbvgBXp2SWP4XdR4
	FipykR58A2QBWKR2hfy4Ekcby9verH+5avgkfhyk8Du78ON5VO/fhTG9Gn2KIrpT3Jp3oW2XqVV
	JqhBNOfXYX0hRPRk+h3HYbGjMw2YFBRd5+HMHdvfrmFD0M/Mh6ZnPdc=
X-Received: by 2002:a05:690e:1286:b0:66c:c215:ef75 with SMTP id
 956f58d0204a3-6714dfeeeb9mr1693024d50.19.1789425344497; Mon, 14 Sep 2026
 15:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789056660.git.zhilinz@nebusec.ai> <7d2cb8e8dfaa9eb8fdff85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai>
In-Reply-To: <7d2cb8e8dfaa9eb8fdff85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 14 Sep 2026 22:35:33 +0000
X-Gm-Features: AcwNN1WUa8mlYWrVLO0LqM9p8NTaYEkhDdFDcjWZEzIHDnE_gBeKM8jut5VcLDo
Message-ID: <CABFh=a5jv9KG2g-8mU+kxmEawr0aMt15du0aemA73uq9k9McAA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] xsk: use a 32-bit compare in xsk_map_gen_lookup
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	jonathan.lemon@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 5:07=E2=80=AFPM Zhiling Zou <zhilinz@nebusec.ai> wr=
ote:
>
> xsk_map_gen_lookup() loads a u32 key and compares it with max_entries
> using BPF_JMP_IMM. BPF immediates are sign-extended to 64 bits, so a
> max_entries value of 0x80000000 or higher becomes a threshold larger
> than every zero-extended 32-bit key. An out-of-range index then skips
> the bounds check and the generated lookup reads past xsk_map[].
>
> Compare with BPF_JMP32_IMM so the check stays in 32-bit unsigned range.
>
> Fixes: e65650f291ee ("bpf: Implement map_gen_lookup() callback for XSKMAP=
")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

For xskmap specifically this scenario is pretty unlikely, so this could als=
o
go through bpf-next. Feel free to follow up on Sashiko's feedback, but
they qualify as followup work and shouldn't block us from merging this.

>  net/xdp/xskmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index 3bff346308d0f..bf00d6463c191 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -124,7 +124,7 @@ static int xsk_map_gen_lookup(struct bpf_map *map, st=
ruct bpf_insn *insn_buf)
>         struct bpf_insn *insn =3D insn_buf;
>
>         *insn++ =3D BPF_LDX_MEM(BPF_W, ret, index, 0);
> -       *insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
> +       *insn++ =3D BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 5);
>         *insn++ =3D BPF_ALU64_IMM(BPF_LSH, ret, ilog2(sizeof(struct xsk_s=
ock *)));
>         *insn++ =3D BPF_ALU64_IMM(BPF_ADD, mp, offsetof(struct xsk_map, x=
sk_map));
>         *insn++ =3D BPF_ALU64_REG(BPF_ADD, ret, mp);
> --
> 2.43.0
>
>
