Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423879;
	b=PuHKVJMFTuCAvUuBVXDIeOfuH6y/dhEGGjkY2zkGq5yLo8/tmbR7AD9ZAAvmBaOq01J5
	 q7XRdRV8i09QIddpn/qiiLWsFnr9dLTj4AWY+85wnarDfPuB0ZuBTh0o++qJzEUt3fyX5
	 ki+Bz22gGev5aYGvZzzDk8UKcKPRqm/pok/iQvSObEb/NAgfvm7EemmvRdjRs2ZvX82wy
	 iKKPyzCb441JbiTEjgVR+ZGG/ot0Po32oWlRt/r4VF1MyoRuHoBCsKJRrosDuzOs5lP8W
	 Ec4OjvvMvfilr3/n4cRyvXEubjCKq90RGlvjRDoPnNR8Tf09u7sflaQsAngP+m1C9YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vH8K0tY0TTIHvq5G2+R9r502vTAhxsKA0mwhegsYO5c=;
	b=BTeGItIhOmX3NDW6quSdas/9ahTlo59ITlF0EchjxXzusy0blRNO440Rh+6VZDZWkJaG
	 StpOgeq1fdjuc8B1SGPtveAkJUXlyW7FLV/zSApP6nT2BbvLxPaWjJTM3PWANOXWhfnWB
	 G1RU1129v7pK+/w0SKtgXCCMVXI1nejK2G0O//j6Ovyj96RDbq0WC0TRo7PdWuZ17aJkQ
	 esLNtfZWk9wJ8KQ9kyR0sBSzi5gm2/VoTWU9ZcpEGKU2Exlif6J9zG+SRwKirwe+2Pv6M
	 0muvcAIjTvGPUGoD0YYW2JgDISImmU40XqdzxN8tlyiOvKOJW9b2QZ+y/9y8cyGpihA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UPpsJuHE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037D60ACCE6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5037D60ACCE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UPpsJuHE
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535f598d126so433571cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792423877; cv=none;
        d=google.com; s=arc-20260327;
        b=SqR8rkmU6YW1SlcFPcL1iINzjnmYazJZZjaxqYHH9pwq6UoKU9Vc0JVAFSduE+x0hE
         Xk0BtnggWqEX8tiZN5UBHPeycJpoBXioSLwoQq8yARJt8yMnIs0roEng4Nh+sseJuAJT
         sICj6waSHJjYkjYfudShAeCKDV2QHPKkiylwMJSZ4gHWMjaLtVa6C7D2h5oxvk7SWjIG
         7/rgVu2+TyotXup+NvVi2pe2Aj3t5CjZnMJNuxqmg+5PtqzT2dB6lnhUGvlxzhZxpX7F
         tAgOiRxwdw+P9acsR4Uh0LI6Kjjz3F7N2/029s0SjWvJXwHUf+M43oIST1Teqr9fL0FA
         s+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vH8K0tY0TTIHvq5G2+R9r502vTAhxsKA0mwhegsYO5c=;
        fh=Qm8I2+cj5Gghk6wauL5/9WWExm9OhE0zHhX7NvKJgVA=;
        b=NHgRbhXL2cy5odPEKvILESa3hE0+Rxh6H3ykr93V9omNjvW7NvPbAF5EvWNpbsbVar
         uFh33y8FWlCRtyhEda0sue7xIAprwxmz7A9LSfsYK0lxLI0tDG+mgp/QQgPeP94FU5rY
         fcGfyGcdV/k4enS4btJpqZpFbhd3crZ0HrgsEO+j1xzuZYsRyUcmK89L9WE/n2Yryv5Q
         jMbYxXIqQTufNDQmH1l0wdv0tc12ZyG8+Otwi+V7YECy/GlMEP3bFUKADL89SEsrghuF
         9lgo7omiuuhisfBftNSsRwzmrJnAyzVh6Y498YhjMZQVZRQOF107Y2xCXYYSFZ81YDrL
         I5IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792423877; x=1793028677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vH8K0tY0TTIHvq5G2+R9r502vTAhxsKA0mwhegsYO5c=;
        b=UPpsJuHEPgv0ykjk6AgT2el3DqaUNvZ/ii74oL+fkA0VD4d6rEpTHFBb9Yd2m17Pyk
         NvgNWaGKTGRoSixKO+UmU1+kAex4grt/wH3hvHULqXf7DFv+QmNGEbYbvyJcIalXdOvH
         yU30rRb0q2rl7ASvSqCML4e4l9cJu0nDIwGfTjClRgIC22QiuYccXCQKX4tiRGQdVIhy
         DjyGSWl2fi5FdquSZMtl61xJv+z9ody6d+qyeeuXf73LgoJidyI7/CNBKnxw/J3Diear
         C9cFn7Eiav5vWJYbS6Bs08c29j4r4R9cj4DGj8Rq0kKo8ZDI7VusqfvvVCfNBY8+UIaa
         vxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423877; x=1793028677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vH8K0tY0TTIHvq5G2+R9r502vTAhxsKA0mwhegsYO5c=;
        b=NlZEUHps3N5gnFXWolwM11oVKYwZiVbE4U4PgF8FvKgllwm8NGlp8mRh4nYfsxG8Bh
         6doKOhamqxH/pzsjVQdMrUboRCQ109Xd/uOjTavfEic7KcDh+ldZvyVSgAjB1pYi0j78
         lFnJcg2A6zkqdS8TYvDuKqRengmmfMiFYcPAxjy8SO491V5GBC+e1CuYbelQihQ7mRDS
         QJ0ZkZ/TYBwNtVKSEvVBnhZtM3fimG86yP0Y7V1+YEE7ydent8NGFYj25ruPmEY1xhQp
         Znc+CAXSvUv7QhNxSL5Y11tYSO/n0B3vMg8VpIMYA5i6t0Qoj95Pubj0qrrFLaWsvjRx
         Iygg==
X-Forwarded-Encrypted: i=1; AKwUvBy5PoturvfORpfPwmG9Z3bqoxzw+d+6Mo+PCx7qkpNSO5HmC5CChNp939BoQRumZWkrICRi3k0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIacLxlmiByU64GuMapouYo/eJcx66oIqUsXp1yXd0Qap8jR/Vi
	UmB8Eh1aqKFgh/d3S/bVYTIHEhXPAreBr8DDBrH1z2mS3ru0ylzzuNB7m71cq+5bDimvZyCW5OJ
	dOwQkjrw94rMlDVM7kohjPUBUGZdNDWaRcBwto1Iz
X-Gm-Gg: AYBFou1LziRB8ZKhH67syXQ0o03DC916pGr29zhi8DYO5OyyarrgqmZ9vVIsfn8Il5P
	PUI1e19hqk2z8oD4AFxWd9hnBS4q6K1rk0/x7XFRoPW/EuU6xgy7gx5cJDDN0l+Zsv8BeygwehH
	qUN1KQAq/k1lle5H1priYNKLsksoByeQ3CKMjUhnJZYZ6z/oyPjQLtZoWBAH1fAiYnBPZjtmMyw
	cOhidbT0j6xL+/OCBH5e6CeBe19YHdSUcn+A28PUOLUJXgxj4cX4pMZ+Wv/pGkb5dOliJWey3pu
	VfXUIGFmJHcFCJs5fdcz3Lcsg2sZwt3xQL7bU4pIQXEeR9kHJefzVxzkY1Rm/wHmIeGBCRBzCgj
	FrVN1BKIK9+irnTGMgVco/VtKw5/mjVMpy6hMe937YdWC
X-Received: by 2002:a05:622a:aad1:10b0:533:9746:9a86 with SMTP id
 d75a77b69052e-536499e8967mr30482911cf.5.1792423876418; Mon, 19 Oct 2026
 08:31:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com> <20261018211514.2817293-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20261018211514.2817293-3-chia-yu.chang@nokia-bell-labs.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 19 Oct 2026 11:30:58 -0400
X-Gm-Features: AclHuK_qCj8A5BQKckfNFBVvGNcKwP79HUqCKtNoolioGZCyxzrnsutbLK1QZbo
Message-ID: <CADVnQykcesPYsRFmZGRJm93knNbPnWf81s6qu30g8Et-rYjsYg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] tcp: ECT_1_ESTABLISH identifier for CA
To: chia-yu.chang@nokia-bell-labs.com
Cc: ihor.solodrai@linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, horms@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, stephen@networkplumber.org, davem@davemloft.net, 
	edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	kuniyu@google.com, ij@kernel.org, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, Mike_Rudolph@comcast.com, 
	Jeff_Howe@comcast.com, srichard@netapp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 5:15=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> When connection is initialized after ECN negotiation, this patch
> enables CA to control whether ECT(0) or ECT(1) should be used.

AFAICT this should be "When congestion control is initialized" rather
than 'When connection is initialized".

> A new identiifer (TCP_CONG_ECT_1_ESTABLISH) defines the expected
> ECT value in the IP header.

Using "expected" here is not as clear as it could be. It sounds like
the expected incoming value rather than a value that the CC algorithm
is specifying should be sent.

Also, the name TCP_CONG_ECT_1_ESTABLISH is quite verbose, and not 100%
accurate AFAICT, since it is used in tcp_ecn_send(), which is called
when the SYN bit is not set, which can be in a number of TCP states
other than ESTABLISHED.

I would suggest calling this something shorter and more clear and
correct, like TCP_ECN_SEND_ECT_1.

Putting that all together, how about something like:

"""
This patch introduces the new TCP_ECN_SEND_ECT_1 bit, which enables a
congestion control module to control whether the connection transmits
using ECT(1) (if the bit is set) or ECT(0) (otherwise), when
congestion control is initialized after ECN negotiation. A congestion
control module, such as the upcoming TCP Prague using L4S ECN, can set
this new TCP_ECN_SEND_ECT_1  bit if it wants to send the ECT(1) code
point in outgoing IP headers.
"""

> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp.h     | 1 +
>  include/net/tcp_ecn.h | 6 ++++++
>  net/ipv4/tcp_cong.c   | 4 +++-
>  net/ipv4/tcp_output.c | 2 +-
>  4 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 1838389a9d8a..b9def462479d 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -428,6 +428,7 @@ static inline void tcp_dec_quickack_mode(struct sock =
*sk)
>  #define        TCP_ECN_DEMAND_CWR      BIT(2)
>  #define        TCP_ECN_SEEN            BIT(3)
>  #define        TCP_ECN_MODE_ACCECN     BIT(4)
> +#define        TCP_ECN_ECT_1_ESTABLISH BIT(5)
>
>  #define        TCP_ECN_DISABLED        0
>  #define        TCP_ECN_MODE_PENDING    (TCP_ECN_MODE_RFC3168 | TCP_ECN_M=
ODE_ACCECN)
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 865d5c5a7718..210ec63538f8 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -38,6 +38,12 @@ static inline void INET_ECN_xmit_ect_1_negotiation(str=
uct sock *sk)
>         __INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
>  }
>
> +/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_ESTABLISH flag =
*/
> +static inline void INET_ECN_xmit_ect_1_establish(struct sock *sk)
> +{
> +       __INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_ECT_1_ESTABLI=
SH);
> +}

This function name is quite verbose, and a little confusing, since it
may or may not set the ECT code point to ECT(1). I realize the name is
chosen to be consistent with INET_ECN_xmit_ect_1_negotiation(). But
that one is confusing in the same way. :-)

Also, using "establish" in this way sounds like a verb, making it
sound like this function is establishing something.

How about something like:

(1) a new preceding patch in the series can rename
INET_ECN_xmit_ect_1_negotiation() to INET_ECN_xmit_negotiation_ect()
(2) this patch can rename its INET_ECN_xmit_ect_1_establish to
INET_ECN_xmit_established_ect()

Thanks for the patch!

neal
