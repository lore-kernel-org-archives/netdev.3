Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792562539;
	b=gRtZLePFcXJC2MhIk9jmUyQ29QqTfLEc7gFzZKHCbSfm0T9yY82cSVUWReyrZF8YkuwM
	 qJE3NsDUqTpQTsR4gbcsncBr/JHi5Tqh0jFP8NyIHYN6XdAQxcRT+10XjupRVHIvB98D9
	 7QQyDwbws1mU8u+kUY+OuBYdd/PqjBr2nsMoz9nHrjfPjUn/JAV1nGh6EU+NW7RncptAr
	 erZ6IDbAvG8Kg3pfIcI3ED3SIZUdOHX1WtAuiAftjAp5PJgSiRzBFr5U4YhA+K0vgjZ6J
	 e+/U+EXmfv2DWAwIZnKznD3FBMLX9PsMMSNwmJVA8UYUzqnVwcVUHJE218O1DP2k3cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IacpiwJ4trEF06DZEwSPiBZm3oyojoTJCMDmBR33cR4=;
	b=RoRLNl9agwn+rjKlthV980hL4dEDVyRDi49JP8LzMuXUZRS4+HXvI0Nlmk2xSlguwOzR
	 GjQO78xB27RakYEY5rtLagSdixApVN2TMIVWbtV7OGMGt8cPh/0DVfdSZEuy4JOZipv4V
	 GTohE8xlkck6fFv+ZfmUuZFYBV9oww1Dn2gUThbgcozcQaZZvo2YxU3KDEZ8eU1EFsa2e
	 b0sVnokRe/swzTigGh7snr+ibaBPWWHPsPQwAMRJyELn1HAoNF+fcM+WCjIxU/CkWk9pw
	 wt0o8ZdeAOgjMCECsAxY+D7I4OtyH2hZlseEuFID346wUE6cNtnnIwcuGINoooGV0NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=q3pkhCUv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A788606A320
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A788606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=q3pkhCUv
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso5115a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792562537; cv=none;
        d=google.com; s=arc-20260327;
        b=ZZzjyvAWECOhAZZYkg10itfmlEqiMdmsu1MQ3fUTJ1E8dm+kNnh5ukW0dNE1W0xNR/
         tfWHFuWSRJ/p8Ow8gdLCTJiYFyNW45EZ8wlo6hSYh5olHAWXol2vDYN8Zs9stXrz0ZIy
         lhEdFvOWoiRy5c+FcEcfKc4Rfzr/MAasTBCS6N4F4/AVAErjqi8kVog+RsMprHt0xFN2
         V1TxVbEuU1Lt3YrF4KSRRrVu+J6ylLvLzQI8og6WgdYFGCaXzZBsL28lXGNzHd/ScSnp
         jUned0CMHToQzgsKMyhs67dRo/neO2IWsByJNqu0XVuwvjfiF6lIEqBZXZfTynC9rHVg
         p9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IacpiwJ4trEF06DZEwSPiBZm3oyojoTJCMDmBR33cR4=;
        fh=ulVbhaWJewOB7pfsvAQF2fYx00cPXz+xdOWIDafiTU8=;
        b=M6D7mROs15xialnHwGZFprsOvtmW+P46zU9U6XVKiEwCgXSjAq0EfRSzDVN1p6lG2y
         Us+NGUhEQHkdHF3C9krFKrAjM5Uy2ADg1dkG8dGbl/4mpEgqi3uqvOYtHjJf7ao99yTd
         GxiMMFpU6AFrzcj01g/2EmiQ/V4c5iBcpjPeCi+gSxuf1U1Y4PtXIIZp/SoutPk+MDYR
         6dpPQtNjfATgXEc0b4+JGPnPAG8+B0N4wRCnspd9NUPxKriaeOdmjdltEkwYDtaLWvuZ
         PMHHrUCWDaMe+hjhrF6NaHQ0AZ5ZCm2hEupXa86eHZhMSa1hRE3q//dnvmfws5CJO5RQ
         NecA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792562537; x=1793167337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IacpiwJ4trEF06DZEwSPiBZm3oyojoTJCMDmBR33cR4=;
        b=q3pkhCUv9nUWBOZccrVMfzeDkaV921iz33aeRXyR17AE1y9cSqfFjgkx+NyopNSRLO
         QOaUT05nQybti3UWD6V4kgP1ewGD3TTnrp8VkN6OR6RxDsTTYIOAwDKZfb2Fmz0QViXZ
         npUW3rOyr3WTDHIlFT4/KQPJMMroas2DVNOQ46D8RJpdtPi+oAxmykdTnrH4/gBYi7y1
         q12HUqRjipCLCo/bs+uO9YCL0K2bTvdmk02L/3tTDEFMlXy7F0n1F9mWNX6T67lJYraf
         HQhvsvGr1DjM79SYNDcVXSoaHnrHCs5vujebegCX8hGUd2mIKbHrhr5jd9g2Mipnwkbm
         CKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792562537; x=1793167337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IacpiwJ4trEF06DZEwSPiBZm3oyojoTJCMDmBR33cR4=;
        b=ZFDcf/CF5Khiufzt4ksyfIGEGB+1W1McUfLX4IpZ34k4+6dCtvL7lTSXN0+LNcBZWu
         AGy33x0mi2nLfG7QIQfurKl1eKr1Kh/my6dLd3xhJLUULXJ7mt0ubmRioCSCJvi8D/Jr
         9ZHfyDA9eQW1mxYSV0uJLhmlzEEbSFHL0kynyWUulRRzn26n8u/5Wi/gS2z0gbv3DvLe
         QFTp7jF4pdD9o8Sw98cAXUEWI0lLHyWoRNbcbrMi3kdPSawKuUBEImqvR8xo+To8YL87
         16ApZzOLmQ+ge7zCiXdVCpPPVzO8rr9Uiznk1JmOdxT910e8mKdyuOs2zCbXLkNBxxny
         ksLw==
X-Forwarded-Encrypted: i=1; AKwUvBxsqPp7ob6DjG1VJwnOMe2DzDmo5ZTqYtDmVDqqhE7d/ac5Ps+VCD5IG0uXcvJX7b7mtnvSjkw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKrDNe16YXsm1szyiA1Ye4qFRmEHwH9+1BvjOF7+gB/ckf/4eA
	vdjvmj8ug8Ly4N1z70zA51DN9EQ0GvjePK4Jq8qPKwac8pRd9JnT8OLLLnZepvY+/uZczNkmcyD
	xROfGiLqSd7puFy6y2OI5sbpzHN1QUt1/xFOT452t
X-Gm-Gg: AYBFou1ghFvb/NiZjNdflQ/HkJe1+K+RiJFJqnL+iv8Oa4aF7qqYz2Cf6530Q/WsmYI
	9RL8ljh1WaGaVNI1OXZjEVaTfAGAZ/k/NnmsaKzXPDpJUTtPcBY4ll4xvSTlvL/1cmht7K9QdwB
	sa4MmRu5IvIhyHGrw5Clhe+PVb5IBHp7MBdq+SVJdLwEzFA1bH2lL7zhvWPyAbJziAuCRNq4nc4
	OLNcQsqw19XWK4TSXpvzvEIo2jqU+p3gHNd1/JYgr4cVYmnVWhOGReNNt1jY5gbxzaK/CQmAid/
	TWwSbox8KtzxkPgEfBc/jv/DSQGHWeXjj4tiEF/nEap3UKx2PEB77KMg+WxZ2qJDowjQFZcToRP
	HgwdBAZPbQ+HzoLKmCRaBA4DB/T8WUkrj7Cw8XubL8ju1TLek2Piu6MUfj84sVNwipCm9hQs=
X-Received: by 2002:a05:6402:14cf:b0:6b1:bbbf:25b4 with SMTP id
 4fb4d7f45d1cf-6b3e5a5474dmr95391a12.6.1792562536864; Tue, 20 Oct 2026
 23:02:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020163835.4076594-1-tavip@google.com> <20261020163835.4076594-3-tavip@google.com>
 <20261020182043.4bad43c4@kernel.org>
In-Reply-To: <20261020182043.4bad43c4@kernel.org>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 20 Oct 2026 23:02:04 -0700
X-Gm-Features: AclHuK-S0Ui5RYs0FXdYffIYsww7_eDbtV_O9m-OKB2qGOVBMwFfZsAC_baGNN4
Message-ID: <CAGWr4cRLv8k8HHnz7Euh4FC+JXoPLS_vGpu+3X=ORZSats=XCQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: net: packetdrill: add test for
 negative sk_forward_alloc in tcp_wmem_schedule()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 16:38:35 +0000 Octavian Purdila wrote:
> > Add a packetdrill test that drives sk->sk_forward_alloc negative via
> > tcp_collapse() on the receive queue while sk->sk_wmem_queued exceeds
> > sysctl_tcp_wmem[0], and verifies that a subsequent non-blocking write()
> > under TCP memory pressure fails with EAGAIN rather than returning a
> > negative copy length from tcp_wmem_schedule() and failing with EFAULT.
>
> This is failing in our CI, it doesn't need any packetdrill updates,
> right?
>

Hi Jakub,

Correct, no packetdrill updates are needed.

>
> Here's the AI report about the failure:
>
> The new packetdrill test tcp_wmem_schedule_negative_fwd_alloc.pkt is
> failing in our CI (both the regular and debug kernel configs, all three
> address-family sub-tests: ipv4, ipv6, ipv4-mapped-ipv6):
>
>   tcp_wmem_schedule_negative_fwd_alloc.pkt:105: runtime error in write ca=
ll:
>   Expected result -1 but got 3680 with errno 22 (Invalid argument)
>
> Instead of the non-blocking write() failing with EAGAIN as the test
> expects, it succeeds and returns 3680 bytes. The kernel log for the run
> also shows the test's memory cgroup repeatedly entering the OOM-killer
> path (try_charge_memcg() -> mem_cgroup_out_of_memory(), "Out of memory
> and no killable processes...") from inside tcp_wmem_schedule(), rather
> than the write() being throttled and returning -EAGAIN as intended.
>
> This suggests the test's reproduction recipe (tcp_collapse() driving
> sk_forward_alloc negative while sk_wmem_queued exceeds
> sysctl_tcp_wmem[0]) isn't landing the socket in the TCP memory-pressure
> path in our test environment, but instead in the memcg hard-limit/OOM
> path, which the companion fix (clamping tcp_wmem_schedule()'s return
> value) does not need to handle the same way.
>

Thanks for the report!

> Could you take a look at why the test's preconditions (buffer sizes,
> cgroup memory limit, write() size) aren't reliably reproducing the
> negative-forward-alloc + EAGAIN scenario in our VM environment? It's
> possible the memory cgroup limit used by the test is too tight relative
> to the data pushed through write(), causing it to hit the generic memcg
> OOM path before/instead of the TCP memory-pressure check.

Ah, looks like my local .config was the issue
(CONFIG_MAX_SKB_FRAGS=3D45). With the netdev CI .config I got the same
error and OOM as you are seeing. I'll fix the script in v3 to work
with both 45 and 17 skb frags.
