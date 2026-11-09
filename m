Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247955;
	b=sQDJ5omKfnimOygI7d5UyJQupGyoRcwZGRW4qoAhO7FyYFnWHK2y9Ndujsnsv9BxnC48
	 caKQDnPEWKCUCEhTuoT6+y2djw+sGSWbW60DXNrj6vX7sz3WfgwIpCqoiiFx8XMI8WEMo
	 KL7dsoTU6wgVwY4xywqitTDNer9ikAMK3XfwLI3yg5pAL+kO9/aWDPxS2OlM/z4/Kwog9
	 A/GPwqN5v8uEon3B9ai0CkgjND2lh/khYJL5cdnaGWClKGEYMyBIPOvnFWNjAQlbAvCWU
	 AnYxzymfC7VkiaPbX0L64NKhwBiKgSBRcVfH49VGVx89gk2fjjtDD//G6ipHEGGt/YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dGm8nmvLy6E2sFmoRptp+D8SP6z/MqgZLc9I2o+BU6Y=;
	b=KvlcWEAN0Br7qxqs4582xuzZIld8Fu1GoF+U+bZabxiu+OiGKGcqufyTfKnZMgnQxKcg
	 XKKHu2rRzKtZqEnRnrW/leDnzPrGXLe3xOmdkWumeGhbPWEW7J/yWQSdOOmoqX18B8mNg
	 +CLJouzQBpjKaN0ZXWmQ6rrIsdnqvU4GpfCihI/v7PdHyRRJdviRVYZglwkHmcwhBLBbz
	 Yuqasl3LRmM1Q9YmUGHwVKAdItEZjanwehkMH16AK9SSeiIu2SZ8KKExYfqvfKA1r+X+4
	 We0zG7p53RQLtwUEWVNjbHfCQChscPYdNJhQ5bhYDO4xc8Oz/0UAjO0LrPXcZg9ps1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbYMaPGl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2F606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B2F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbYMaPGl
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5383c97c8cfso6421cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:12:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794247954; cv=none;
        d=google.com; s=arc-20260327;
        b=oLswB3qP9CHeeI6VCHaaMrwaidbW8SbQn9ytcBFhAzkUQNrT7PQOtshe6KcZAB1acA
         ivJ+4mYUGWOAAQoxJ3VKmlIz17fwhOXNiRShWucWjMj7x44gEpSiJAdyk8BDHrnXJbhu
         IsqV11rBMFFT5lVTWncfgZSt/KYkxDxKuzusF4Q/p0ouEhgeppInOjW3uQeZtXCa90wt
         0VX+OEBDsT2opmFyOmAum0j9qwYyCC4fME75uHFHrokB/DMH/+F64z710sXOx3JLpNiO
         1gEa+8RQffXFZqMwjwCjgH70LkaeX815gw2E/3YyRr/nhbw9TodWGGCfrVnMSdZANTPm
         ja1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dGm8nmvLy6E2sFmoRptp+D8SP6z/MqgZLc9I2o+BU6Y=;
        fh=+jACcBXsLCTXZM4lzCmjrMDcO/yiWn6WERUuQjjuKAA=;
        b=QMX3NpPtjITJ+1JVc9TkzWUfmXW+CgAdkm+6nyA70G4ylW0NEWgCeGxT19LOAiqsdq
         dFO7+yZeHTN6NzkE1574LUUaxfotEQCoPwcT3IMzqcxfvr14nesbeAAQ04XIoSQsrUtd
         KZm2waLynXKTT3a3EAfk8Ib6lnUvdwky5hYoudkXpBcYM+LihQyum54fNxh0lEJZXWxE
         hzOirSIyMY1mBLdfjzbYfsu+VGBMLfoR344REA8K62P6pZfDIyXIfirdcSkU5etO0364
         mikbJSm1QEy7n/82SFuH1hswQYD8OfcVY92uYbH+mg+7Jp1y/POqvggSQXIyI8Dik4Va
         GuDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794247954; x=1794852754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dGm8nmvLy6E2sFmoRptp+D8SP6z/MqgZLc9I2o+BU6Y=;
        b=lbYMaPGlSD3L53Otjd5lj01TjbeqYpzZVz8Cp51Y7SdlWqLTXB6w6agPgvgK9szDKC
         0gQVIvjYBFMavS2gnfDMWL2zzYcuJHxMVMLu4nUlsGHNMbWCjEdW+nGd3WrhdBc52mI6
         aKpEKshPkOMlvNjqk6N4JCiiHzbb9PInyB5PN8txycTde2uK3jXjscOkHRr25Df9BJxm
         wntAtPF5/XluRVUwadqEHTB6BcYvzqUz8ux4SksT+XbGikaU1FoZYTUAmaMizxDWMKl7
         T99IkR8LWjK4D7DccnbJ60E+bb4NHoJ3RIgdv+FCtgXZbX4nNZxIoRuRSlHFGMLAzVph
         1QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247954; x=1794852754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dGm8nmvLy6E2sFmoRptp+D8SP6z/MqgZLc9I2o+BU6Y=;
        b=PmH8C306TXUSfGb97JjLi/8fK0PeqWbWSoLMi3xo1hFtDGY4Y+ZjugcoEyBbW/4zVZ
         IwMUhC/adZMa2TP24cgvgFZIeX37LRbFkzv5+kpBU3VkvljTZnVrq79/tF2/EzpsHjpt
         K/2VIaAukahF9ot0LEYQ2hGImZnaQtu+gvlB6Ni4SVLvYeiVWTQEXSd5feuP49ivxucc
         ItfMb3w98U5l0bJ22nnWLFNJNXM6TxdKPK6LYnls8zYb+6ECyF1RbQbKeQsTNM/fb+uD
         YwiFsvEGNxmY5UUFSxdRDweNGmVJKCIpCCHhUEe8Hso6ZBL3ueDIkuIYeN8fHRmbdWdm
         hcLA==
X-Forwarded-Encrypted: i=1; AL+hErFLiozP0C5E7RLg1upZbF4QE+/iibJq7n79qi6Z/H4VKBUf+4H7JxDZu2kp9G4GdonRVHrRlbo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b7I+qe0J7z19Nfz+pNsVnGpbdW5zCjSUUcQtou5y7oDgBmMyC
	xkZz+xfqapqqgV/2MlTZyJxftNUPdxr/gmVDkTxc0lzgkprZuIsHY6xinOQobhxJ7cu5hekm58a
	FYgwJMY/b4ect9DpOMjP20vtyHrNw9A2spTfjwDRk
X-Gm-Gg: AYBFou2gf/Lfim/J3wzJQA9zBmb+xgfpPAj3GmuWEvaPdE/VWsM932aSjlHc+9KAjUf
	9wOG49tNzBJATsl/hakUYvCHCFGl6pVrJ9a8lAjMi1+2ThRzTOX2tTHWbnKosPeRbwJwIWbfgzS
	SCLheooM2kfpMV0uBYzUf+KTxQeKFJ9qhRafW2DUcq+S2OynG3g0JduqiosE3oa4TY/MLLtbx9E
	yNptCGksNskszxDxmKIhqp8m/d5cvjOGjYVUgS05TySKR+Rs/+9m/5Hp3wsBBt3J0YqK2uhJf9C
	sdHwybtb//+VVV0eOx0kSgGYm/yfu8qqmspUvEipBy54lev9SvDI8LH/eaer6w0m6K26bYbrh1N
	YYHb1mta++U3cmJmLJX/QTnX6OxmXDkPkvhhsEGmdoHa5w1OvMtiIG0FLTBjWAQ3mrJZU3u8Izb
	llO39PxvIL+8Ge8a4sS4wAXWSTTumW3YyQVlxQ9oK2ts9ceek=
X-Received: by 2002:a05:622a:488c:b0:542:fc60:fe23 with SMTP id
 d75a77b69052e-55530d3d62amr54161cf.3.1794247952273; Mon, 09 Nov 2026 10:12:32
 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-mtu-probing-series-v3-0-dedfab25d641@gmail.com> <20261110-mtu-probing-series-v3-3-dedfab25d641@gmail.com>
In-Reply-To: <20261110-mtu-probing-series-v3-3-dedfab25d641@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 9 Nov 2026 13:12:13 -0500
X-Gm-Features: AclHuK-E7FZmMgLaCJxXz6hIu0FtIdqq3ijAk57SK8zqY5F6VRotgKBpxs38suI
Message-ID: <CADVnQykoJWJL+vZ9GC=RqZuiSEypNtmTONBzV7XRQ1jsXy0X_A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] selftests/net: packetdrill: add TCP black
 hole detection test
To: echoowall@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, kuniyu@google.com, horms@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org, panweiping3@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:44=E2=80=AFAM Yongjian Wang via B4 Relay
<devnull+echoowall.gmail.com@kernel.org> wrote:
>
> From: Yongjian Wang <echoowall@gmail.com>
>
> Black hole detection (net.ipv4.tcp_mtu_probing=3D1) has no selftest
> coverage.
>
> Add a test where a full-sized segment keeps timing out without any ICMP
> feedback. Check that the MSS drops to tcp_base_mss once tcp_retries1 is
> exceeded, and that the smaller MSS is also used for new data after the
> retransmission is acknowledged.
>
> Set tcp_retries1 to 1 to keep the test short, and disable TLP so that
> every retransmission comes from the RTO timer, which is what
> tcp_write_timeout() counts.
>
> Signed-off-by: Yongjian Wang <echoowall@gmail.com>
> ---
>  .../net/packetdrill/tcp_mtu_probing_blackhole.pkt  | 37 ++++++++++++++++=
++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_mtu_probing_blac=
khole.pkt b/tools/testing/selftests/net/packetdrill/tcp_mtu_probing_blackho=
le.pkt
> new file mode 100644
> index 000000000000..f10dbb36dd2d
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_mtu_probing_blackhole.p=
kt
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Test black hole detection with tcp_mtu_probing=3D1: when full-sized s=
egments
> +// keep timing out and no ICMP arrives, TCP falls back to tcp_base_mss.
> +
> +`./defaults.sh
> +sysctl -q net.ipv4.tcp_mtu_probing=3D1
> +sysctl -q net.ipv4.tcp_base_mss=3D1024
> +sysctl -q net.ipv4.tcp_retries1=3D1
> +sysctl -q net.ipv4.tcp_early_retrans=3D0`

Thanks for the test! Though because of all these sysctl settings, this
is testing a fairly non-standard configuration. That's better than no
test at all, but IMHO it's more important to test the default
configurations users will be using.

So I'd suggest renaming this case to be something like
tcp_mtu_probing_blackhole_no_tlp_retries1_is_1.pkt.

Then I'd suggest creating a test like this, but with only the following set=
ting:

`./defaults.sh
sysctl -q net.ipv4.tcp_mtu_probing=3D1`

That way we get test coverage for the most important scenarios and
code paths, and can understand the behavior that users will see if
they just set net.ipv4.tcp_mtu_probing=3D1 and do nothing else.

Thanks!
neal
