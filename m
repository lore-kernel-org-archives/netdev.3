Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267687;
	b=jvVC9YipsOLlOpRu7iffIPI62oyeJSD+GADFc5F05jagNxf3JaN7UNBb2tzwClGs12GF
	 hSmdhKKCex0Fltr1YSGqijqi6UUp/CP4VHfRMbH7bDGbgH8jeulFFHmL9kkb0szYfv1VJ
	 j6jwoUbK9APyfpd3Fd/TDe5MbarQILBBw2BdJoOQCOshGY8iIfPeBrcICxUjWeOMstRe+
	 XzBq+hihfs/d1AAq/N0ZLM5UNbM9gBNYsOujHVRZPLgOpNS0AKtSpD7mAKSx3cQRyxfwX
	 ffSuYPZhNRXEeFh+d1vEyiBmIi4ipFXcbf35ShWutHd2rkdnyMLQGfhOu8M6l8bpu8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267687;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tgp6+c0lKpvLgsOQPpdfs5HhPuw/naLn+nX+F62Bs1A=;
	b=3RKqBr+EPxMHkKyD4ZFnJh5IFeNYUucqGH1DK5Kn6y5NrxDIkAOKJysen3wk3HuXBR5h
	 b74hRrY0OXsrF/gnm9CnbFJWTl3ojZdyHky/P+SAsL4mL76aI1yciIxpI+zcEOHU5FThT
	 LdVl4Iy+JfHigg5A8IyBE7No3Vl4FhhI5avHX41/jB1hg+MiAUBpr/z+04cxaH1HMOsty
	 SrEFsHWPeOcsNXZ+nG0QmyiFPHRS5WwrFq2qgBWrukzO1l1oDQfYSaIxeGscw4cL+V8sZ
	 4/NYWaoamrWp9HEc17CNVuK+YBFMtVZUick6HyCkTN0j6pLgAaGfQZ7eLcQqL2ZdNNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwFcxwpo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494260A2608
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwFcxwpo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93B31F008BD;
	Mon,  9 Nov 2026 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267687;
	bh=tgp6+c0lKpvLgsOQPpdfs5HhPuw/naLn+nX+F62Bs1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kwFcxwpoPmtHZENsp4ErdvCda3ELXbUNMxwO5btXM5sv1u8SuE0UeI8J3/bHuDklW
	 poZwnswY66+bwe4Lg2OUzDM7aw+HpTmt5mN4KPwnekeRl+59e6EGmUdhSPwtu3TYST
	 1GCX9ASJvxgdPhUa3WAr+UyXZ05EkauwrlJLieMOoHS58TZax3PBOJ3N8RDp3HwPlf
	 w6fK2jmvjOkKWaLk1mtsGtuMtH/Xa6fjtEsGIMxHwgntLV2x2oDAM5J5EB01gp5dUG
	 OL2XVccR5gqG2cx5Tj9Wod1Xc4aB55D5IZwJuSELaHJn5XuPP977sUfiBb+oFfQoYJ
	 2uBlLaN9CZz9Q==
Date: Mon, 9 Nov 2026 15:41:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 1/4] selftests: net: py: add metric output
Message-ID: <20261109154126.61b2cb7f@kernel.org>
In-Reply-To: <20261102190827.989117-2-sdf@fomichev.me>
References: <20261102190827.989117-1-sdf@fomichev.me>
	<20261102190827.989117-2-sdf@fomichev.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 11:08:24 -0800 Stanislav Fomichev wrote:
> +    Metrics are printed right before the result of the test case. They do
> +    not affect the result.

Is there a strong reason to do this?
My intuition is that buffering makes debug harder, the parser can
easily extract and sort the metrics on a successful run?
