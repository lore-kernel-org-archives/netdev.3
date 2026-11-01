Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793500709;
	b=e6dW3Tl+3xSJxOr2YeUlvvEvH0sjFnOZVR8H7u6M0q2V9oa6wZD0ezv7xm7dG0GwHCI4
	 ChPE45atPLTyFkWjqhPUXp/qtnUQh+//iZsEwHELOtbO8hgufcgyd/0y/wN8uDGW9iujA
	 lU/ZsDB7Z8T/9sLFWo2ISOXTajVxO8triyYlVUMeZgT40xcxL18GvMhb8m8eU2j4A/Twe
	 qsbvO/R8mKEKJ86WxqUYipeYINiVKHMFB29NvAr/nrh/LVXoHHj8jqCDegwLBDAAKLdCC
	 /hf+6/lvpa2bTpp+xN3PUQKoeSe3Z7/zmMRyr4fLqalzr4Edih+8qPoeUDa5NmcqVXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793500709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
	b=Cw37bg7mvczZ+A/594GMDmB9RVaW7o4/tKSTubWcEFvHiCwxo50k33vAHV7DePFuG+hv
	 4KA/p7RejWYyfGHcgrNXjkmoAsSOC++K8r2vggiqBjjVa3++7eJvWbzmFocB/+/mB2V7P
	 qz73RAK2/W5ZYcxswsmLLR0nNn+NAa7FdPYSpEdN5mpZ3ff8XG7FlHQ/g4y8OEF0qPIa1
	 0c8MYJw8N/FIgtwJpNsVDYJpFwXIL34QDqe0jlZ/J3sLoWsKL4VvxPkHCXcpPZXW3+iWK
	 I8FE/W3MLK/pqlCFjAZFsx0btaFDtcmN9nDdTp1TnV6iza8s7aJ34woSArOmOnyt2Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ez0Ef6Wk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B1606A326
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 02:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ez0Ef6Wk
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be4fea434bso2449662e87.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 19:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793500707; cv=none;
        d=google.com; s=arc-20260327;
        b=XhYN3AiqlkhTw17kT36Xw91f4rXSJKyZ7+XZKRWjUe/6YjcbAAihE7Nm4cOz9rLO44
         mUALuv2ZKe2IoNxkbLd+DLItvF0ObuNRhH8Ba9LfIPszv1/HRvNEnyWrcl99mXumrwZa
         MWmgq9/0f+ZN/Z96zF23PHlooUi2vAq1VZbw5+G07bsuOkTwD5Fi2RC+j+XBMdrUaShm
         GX2y3J7Eq2MOYZVuZSbd6jyEtf+JmjV88gIbvN20edx9CExWlh5QoC1NjV+6S690HRUZ
         qTl+qnnuULMgwzi+ckyoGo/TtcBJrVAp3QAmWUfmuPgDD/lkPFKRq6as9ocavaACiMjH
         rmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
        fh=ktHE0L6YPsK44u9DpRaC0e7yAWnzqWwk9JGfviY6Cy8=;
        b=c7VGQgpnj6U6GiUB8JINLISG+ve7KHyZwaIne+Eyo4XlvoOUqu+OvclzNUIO67XWi+
         IhwRjIOUM75mqa2w7G1yA+eAvNe0aWi5ql/yMb+w34OLfHn6L6gEsDwWrlo04zx/iFSA
         yL0gGFIs5pJa2H3NnMx3mmBKP9/Hnn+Rfz8H/ahCsPLKbyj7HymWMQKIqpjdWuzNEfc6
         8QYpcD18m6CY2Aio5UWc1VLMf/mJY61bC7tUpY3AlKdohdjeqi/yPW+aew8OrnUP7mDr
         tj+Zptd6pwGsWvx5galR9qFXQ4B0bydbvucX7Djhgrs34H6fbn1IXNqHaDpfUJYXtxdS
         0iXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793500707; x=1794105507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
        b=Ez0Ef6WkIyFnPfzu27thZzh22hC+1ma+rA5JcQudoseX3D8VYdwroGF3YKNx/ccGTi
         DSIg1lM3aZijUOTRaXDEOXa9pywWQUCX2fdMXHk5SSz2l9UU9tUsEvuZxYzooTvjMF88
         3rWQw5CgIdyOPb+EHWR04DSMTRgKdZPC8Qep/ba89p9VLNqBWpQpGhZpjzxDkrihMMB6
         4kM0tYzQyptUuvPthx2qjt/0JeMUNaT+Q33aIGbPBCaZgFVii3iCFf55n3MavyqL1QMs
         aeMu747SSY5helzpAXtMPtVXj/V6fnR8Yz62qiv00z8QMZi5MyDRTclRiwsKVo98Jlsb
         yHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793500707; x=1794105507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
        b=kC/OiSq61ELBzJm9vpX43tijRPSR6wH1u1UIYuxziNPSs/Pqe2YkIoFZGMHN9uOp4X
         dDamL6qVlyuLaAjYF5NdVhesnsUmY16krzgE5f61z95Dhh7eMRaklSa844eIYP7mxweg
         GRLmS2DOyoAAMetK6TSGuExsx39ev7q68tBwFfVgzXAScgOXygxk8FovcacYdkucmA1p
         A8kwDt2+/w/RcmclXqweRxJNTAnwrRFIAZQDOcpjJVsREtOOLfzIr2meS23eAWKtgdKX
         fj8CuK6AU9Rg1uBD0jUU53GkLyUOwQSMjyU3Fq1OOJCQ+v8tfjByle0NeIVhaUs5sOy+
         oaEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnqDiqhC9A45O4q0+n6n2LRhsMKCGCErtQQ6xKRZszjmBzbdjBQKfsDOWJnPiM6se3ZW+QE8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAevo9cPVWHGvaRJM+Mg2iAW/nTQdR+MMINlhxd9HgAPf+SoK4
	tULEEIlu7mg+cqt22+ryQuYh62cdoelNKdpGfUGlA0V1/fMGuJozjhnB6TDNI34DNf4OfimfBTK
	vivU1BiVmAOd2SAR8PHdMXAQLcZiRhfE=
X-Gm-Gg: AYBFou1A8SG9b07HK80N2WJhkLWnTuK/UUX14MQFlm5zLus1rJ3r7eLaYafXWGBXJmQ
	Av92/8CtKAE1Z1XewsDxm2MshCQ2XXPW4+FUoNBBJDR9EQ28cG05ikPdhq4MciIjcFxt8aBxvYj
	UO2A5D5fPHAZH5xGKL0anhhfzg/4FXQ72npQHCq7kN3ACuanXu4n3qNOfamSaia8Jh9Un4JM7Q5
	MLqyLjsqLcErIk+8PUG73ht7aNPTac6A8VpRi1stL69dnMvmGJbLQfPdgpwEjLqLyKpJROypiDd
	nse1eianz56UQbW7pnJ7orrLqnP7TQzJfn+ybwYsx3UoWdjUuojEBe+v6WnSK4pnYgRNSZULwFb
	mwIz3n+etx30qACD9L1tHRVJFGKfogtGcOGrOwsvgfJ0h8dG+VcV0YjH6dDk71ELp7sjid+/TVO
	4FFcvM6/z4xfGG7WiTqI7/5Rxd5HEILh6kTnI2t0+/WhdAcRQRzT0=
X-Received: by 2002:a05:6512:a96:b0:5bf:c9c7:eae0 with SMTP id
 2adb3069b0e04-5bfd9564f18mr1864662e87.4.1793500706846; Sat, 31 Oct 2026
 19:38:26 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 1 Nov 2026 10:37:49 +0800
X-Gm-Features: AclHuK-w2Xb5r-XGPIWLPa0peqPZ35FQ_khofZikgGeMh4wAdy4AzH-tS50Oovk
Message-ID: <CAL+tcoB=SG5WT0VrkhuPp_5VYtFHWDFhWMCNM421WzoU4z9=9A@mail.gmail.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is full
To: marcin.knap@vecima.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 4:16=E2=80=AFPM Marcin Knap via B4 Relay
<devnull+marcin.knap.vecima.com@kernel.org> wrote:
>
> From: Marcin Knap <marcin.knap@vecima.com>
>
> When an XDP program redirects a zero-copy buffer to an XSK and the
> socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> -ENOBUFS to xdp_do_redirect().
>
> A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> most drivers rely on that: mlx5e treats the failure as XDP_DROP and
> releases the buffer when the Rx WQE is refilled, while i40e, ice,
> ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
> buffer is therefore freed twice. It gets reused for another Rx
> descriptor, the second free puts an in-use buffer back on the pool
> free list, and the same UMEM frame is later handed to user space
> twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
> -ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
> after the core has freed it.
>
> Leave the buffer with the caller on both the single-buffer and the
> multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> do. A few drivers relied on the core freeing the buffer, so make them
> free it:
>
> - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
> - gve DQO counts the redirect error without freeing the buffer.
> - octeontx2 returns false on a failed redirect, so the caller goes on
>   to build an skb from the already freed buffer. Free the buffer and
>   report it as consumed instead.
>
> Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> with the Rx ring. With this change no duplicate frames were seen with
> striding RQ on or off.
>
> Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> Signed-off-by: Marcin Knap <marcin.knap@vecima.com>

Agreed with Bjorn the contract can be documented as a follow-up patch.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason
