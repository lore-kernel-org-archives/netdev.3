Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614932;
	b=2026+j/ukkhqAL2ShpQnISCRKBZMEHU01k8JP7GFlC5uDDEOnWqK9pKTI9fF8ljsp5+q
	 SKz7TchMt6k2wr68xJPfW8hTZsuT9JDfWzdLBDrWZbHfu89fcPqvC9Ym+hRa/gGHcW7Iy
	 IlC9tyH0YhQfzWmg7cyxlaSqUj7jcx4rV/V5M5C25Mb+YgWw23pVW+khCOxI5SeCuTSQh
	 vMS2XFenID/YyDl8wHDfDoPh80nhMNpvfU5ue4/7V+Nu5jrpql1KZ0gLq1PdVwTn94ufy
	 1eDhaXlh//dxh1haZfdG+QicZASkVg9JDKkg8i+Z2KKIBVD3Df71Ng95Cph8thmy4Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614932;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EG/ZMycKrbVRfxUfFqSo6eQSP7fmb/CGSyRpc3gc5Ik=;
	b=yBZLWs84qY1PgvUu5dkj+Z6aKajU1Fx7rpDQhsjS6JO0cfQxa6b+vFkB48kxLRleHvMZ
	 chB6QcGubtlQftVhoRc2P6OcLYNs5c9nqu7EuDUNCydy9y88NuI9l4lhk+4Cj9iqmD5v5
	 xF0DKysGU71gX9LNk0I7WIVDOxC7ueH25e0qSquy8KjGzgtQ5nfkbSXGFFo4Jnr0+/rlh
	 SUWCLpm1nfnrkj8jFwIjaV+P+FNiTQ7k25dVHcNAzv2MQgQ7NQANqxZJonNJlrmNDFiNH
	 /nWB6NS6BUHKAhNq2o3zoFnKaF01PeqiWUzHcMqwraC4vRJ87VT265h0oavh4lHlykg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dOmP/9+s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFF606A319;
	Wed, 21 Oct 2026 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOmP/9+s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F611F000C1;
	Wed, 21 Oct 2026 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614932;
	bh=EG/ZMycKrbVRfxUfFqSo6eQSP7fmb/CGSyRpc3gc5Ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dOmP/9+sHDj0cAtTJuH/GU8IAtzPhfAYLEA1sOfaBsxcMVdQb1qSkxfpm4DyOs3QA
	 w5l175mmtlICr6g7UUepJz2EkRwjXrDCGaTuBmPsAwKcawF6OM5KxeSNkz1BDbFLfM
	 R9S3YYjnmx0KfcWoPOhtNrhOJ659RxblO2ioUuwjTSwyJXGIAv/wnrjhye3acb0Eh+
	 10l2snd1Er8Hhma1vJuzIW3zFUq7utrb2yRMd1EdzmvoDmEO+rNFozGQNauNwB+qin
	 oN2U27VDg2ImaStdsFCe0nDqpyfmC56N2FQsc3ugefY9sRbZ4qcQCchJqcbmPPg8o7
	 /EOpKOTg7cmhA==
Date: Wed, 21 Oct 2026 13:35:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: chunkai.deng@oss.qualcomm.com, mani@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tao.zhang1@oss.qualcomm.com,
 peter.chen@oss.qualcomm.com, jeff.johnson@oss.qualcomm.com,
 konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH net-next 3/3] net: qrtr: implement shutdown()
Message-ID: <20261021133531.55da7de5@kernel.org>
In-Reply-To: <179248895481.3135.9231497728918795508@kernel.org>
References: <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>
	<179248895481.3135.9231497728918795508@kernel.org>
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

On Tue, 20 Oct 2026 09:35:54 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] net/qrtr: shutdown() API violation leaves sendmsg() threads
>   hung

looks legit
-- 
pw-bot: cr
