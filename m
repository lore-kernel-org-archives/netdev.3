Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938E3BB682
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782507533; cv=pass; b=n9o8vob3fQt0ztX0qXZVLOceteJQ39HI939OzndJEkwUFFsbc2RP/i8f2zxGgJ+maEFXLkK1C/bY8Izf0nLmS+HWbmO7UXcT6Lr2U6fcrmyS3aVBawKEQkM/3saffjwCvVrzLL+2eDS3qqo3FVxe+60QkDw5q4sTf7DRXssEy0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782507533; c=relaxed/simple;
	bh=6xbLFFtqBJ01FSBulKyjDCamVJlD6Oqp5iYuAsl9x2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZ+9FiAep+QV+iucRt3NLUQXiS0820e4gYXlxO1plA257vuhRFWFVC9rLnQ0Q7lPsDGSiNpTReOI3bIZ+iK5de7ojf2NHMzKbS9x7x1s5GqLCKg3IuY9s6kSvQIUrYKhXfaZvKKjctqYwIrgBriqtj/uVjBOXZ9FgRcA+/ffLJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toCfuY8t; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toCfuY8t"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1390f75d8bbso2424598c88.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 13:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782507532; cv=none;
        d=google.com; s=arc-20260327;
        b=KbxITNmQbxCN/ncG1+M8tFgB157g0w7dYLxPWCvalYR3ao0GvRmPvoCkE6tUKrfYxO
         H/nwXBaMmerKqBFmNRm8/UnjxMK1lwoxPIsjjuMxl2SoXSjPQClR1KfaRQjWvkCAlvP7
         f2ISbN4JtxUWuXE9uPmGQO9DlN+79PwlsmoT/m7K4r6XiEIQbb4hkDsivhMuT/EeajCM
         CIStiwvynq+TZ2LXdlwTsIvctAfcGBtucHSfUPNmQ+Cpd/IiooyfW3uR9LqRiehMvAPi
         EiFXsrbH2RagBhikDAuxgDzC1tS61JCtqpn/bPC2Tzu4c2xFzq0Gcs8WMGtlCehvba0k
         00uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8WYF+0x5GNVnLrxh0pZVzPZyopUV+zJjv6tx8gPPi0=;
        fh=gNeejt9OHo1BdpXsSdBVJeMn+I1OtgTtorpX3nbHg9U=;
        b=JJBsQBF5OVzPOPBaXBm/HJ5Go4wTgevJddpjsYDtW/jIOG1/B56D4GA5Dbpe49P8KU
         7sMMN3B68qiDIOwcfQyIGdQc6Ttz2b+go2LP8fCk1K7irflOko0h9mGQ0TnDXoOl0hbe
         7u4bNTCfXrOOydSK+QXLmODTIvXQ8v4QMoLLAeO5QOu1Oaq8co0TxxcU/kK3u33AODEL
         71YD6+cp6MhYghWI9mlCTEVmKAY0rL/Z/6mlXi2AhafZsTOXIqp5hCTMJUMpBJaPw+IV
         +/mXCd96k4OILoKva/wAqzHdwTuiwAjrJU1yV4JVnbtOglfrnIvRDMqtQ9R5ylQBQAmO
         8Yng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782507532; x=1783112332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8WYF+0x5GNVnLrxh0pZVzPZyopUV+zJjv6tx8gPPi0=;
        b=toCfuY8tnZglDXvHih+sU5z8TlaYroWWJlbxW4++Z4MzkWbG+wTTygYubM1KAnQa2D
         oGylxxSh9C/i/m1/dvgb1LlrViqqH4m+5VRV2Ac1jND+AYIUJWMTFlN5AjnaAm3bVPCF
         3DbQbQTlPxiOXx6MqGsRrvQM+RHAI4WRovF+fs/xtBYQOc+13EkHlx6c5CVeT7WkBMRy
         E37qErtYCVS+doAw+QJWCD4i82Bmh8C394EO6grp6J5jr8UmitsdYnyqS1q9fIQbVAuK
         ep9+WIwKZ+MmlxzQXGef5WYTLI9alqZL06BA5aRJCH9epgn8sS4DoqXgdKVjkISZD6q5
         E0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782507532; x=1783112332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F8WYF+0x5GNVnLrxh0pZVzPZyopUV+zJjv6tx8gPPi0=;
        b=EI0Kt9O6p5Z4LWjNIy9Em1zSliG7aXXd8AHHdeeTMYbNPZq/3DDba2tjw8Wp+bwY6E
         IVh37Sk1PIrWh2OFgCjmFyTtUd6ZEH0+M9cBWHHSypemwYHH1ZHUbGap/c1WP9317kg9
         1mCMpYn8COrUiZeK/j03f8wtx2FzQtW9H/wET4FFQDzy1+fJ1hpLvuSSQXIuMTiPV2Q8
         rGrsGTJWyxDhybux+OpjHpuX4tcZ6uVR/+UI5j3beti1n/c18dCNeiF9UNqPJ3+I8r3M
         ZVyER0dpyFyFu/aCR+6b9EEFO1cnQPoY92v7WZLjLttS/Si+BNwOTEnw3EbrxAsvAx3u
         6dLw==
X-Forwarded-Encrypted: i=1; AFNElJ9FdPpPt7BccANj1JAcsn6tX9Dy+jSZpe/8w99RzL2vk3kPBu8+gFr+++Jpg6tJIxE4+SYItRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywO7el+2XUq2wLYLCeK+Gfyd1ljJ+6h07o0shP2pnmpXGPrkWe
	3gZK6q2xjc1pY2vdMc4es9cQWEoy6oiHxVOeNcVaUIxO1dKMbG7jyIlM/tbOMPeJNKbqQX1eLBg
	lKdYGgXj1aRgOcHT0YNepk9zpEZdpQl1Bp7QT1Eou
X-Gm-Gg: AfdE7cnQvcLolEAt0FxGARl03Usn+224Yn4JcMr3gPS1j4SJuM1tP41q32Dvne63lY4
	OjdyWFS3IznBfdemq83g+p5mB+nykyezT0+SfGsZxXSKwRqD3mBhSZKWPnONNRqv4j67g6jTr4l
	k2K3PbBvosE81cC8XfuYZgr1nESBYpsOuDEsJhPRhPoKS2bUG6Lq5BEu432qsX7olMIROc1T2Xo
	aJ0nSCt7aaD8dL7bXG5s5NXolulU3wElrWa6+mSXTx3G53Y44VeT2WR7sxS8OpwMKjIqlm+5Uti
	m5hNJyT4GfjzeJ8dMECU7lj8QBXf9bzrLXJLTMfVYk6JAK+x5CaAwktMU8i+tC2qoavdmAjm2WO
	zcsiCn6rUACluywZHWeabkpSuObye5D7uc5bs6Fs=
X-Received: by 2002:a05:7022:629b:b0:139:b63c:a0f2 with SMTP id
 a92af1059eb24-139dbb8bdb6mr5708446c88.33.1782507530580; Fri, 26 Jun 2026
 13:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co> <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 13:58:38 -0700
X-Gm-Features: AVVi8CeP2eiu_fzuvOztLhngiE1Tsu5qut2zHfev-g_7GKVOiJ1ehpzU4Kk_fcY
Message-ID: <CAAVpQUDULzZh58oKkRaYqgM9bRToGb7wHrzT+cZNpRmAtM12Ow@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/4] selftests/bpf: Adapt sockmap update error handling
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:37=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> Update sockmap_listen to accommodate the recent change in sockmap that
> rejects unbound UDP sockets.
>
> TCP: Reject unbound and bound (unless established or listening).
> UDP: Accept only bound sockets.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 17 +++++++++--=
------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index cc0c68bab907..6ee1bc6b3b23 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -63,11 +63,8 @@ static void test_insert_opened(struct test_sockmap_lis=
ten *skel __always_unused,
>         errno =3D 0;
>         value =3D s;
>         err =3D bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
> -       if (sotype =3D=3D SOCK_STREAM) {
> -               if (!err || errno !=3D EOPNOTSUPP)
> -                       FAIL_ERRNO("map_update: expected EOPNOTSUPP");
> -       } else if (err)
> -               FAIL_ERRNO("map_update: expected success");

Initially I thought AF_UNIX still exercised this path but it was removed
in f3de1cf621f7.  The leftover in family_str() was a bit confusing, so plea=
se
follow up on bpf-next.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
