Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F85304A8
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664470; cv=none; b=KcYWV4IrybLM8gLNxYJ0W4HKIDi3twCkouZqYByvpqOdbC4GIfiJRGFsLb/bD3QCS5FTrtVwESRk+avkUhawEMFB/TQU1iSGU6qneAU2TIkw+T+9yA/OLK5Sdn85Fu5AaFHYplWsAc4LpuglpivEW7zMqbcllD3DE2MFv8Vp72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664470; c=relaxed/simple;
	bh=B2DIEOfiu6m2jYhcfQxwPgrR40S7t8sjAFAF5ReukeA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=TkQcXCdYJ9qEyDdILSyyREHI9NbNMg0DhiMp/LMU4WmwyAdSV9OnxQBO+Al20hqijvtZaV0twvUMgFZR58gtiFlfb/hDD4n4OVrAK9IOqb38VSS4u8JGgBQ1lmTK/UPRzkwECEqE8RG1XroZNFrc8JioRWbGza+CaeJQ9KiUPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oP2U1C6v; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oP2U1C6v"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24afso835520a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664468; x=1790269268; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9r+Nmb9u1of9YV/2d3L5W7crVXgzglxIBbWntwiFrig=;
        b=oP2U1C6v6NEuEi16j4ISIERfcbQXIWC/tguAFAl/1xgyF+3FT/wu/+znaqKJj/iBDa
         ssMEyKWbUgRszefgZ3s5T1TCbePIyN/opF66r6MEpBq+oEbD+Xh/7yn7rtfOHjVtIf3/
         9Ze4VZR4l6LAETtv3bWgq9m/1Xsmr+KeWC8vKpzd2AQl9qbmIRC2Gbb7qnFA4jgoxT23
         +3ThUvp1elhnGCbnVuubwU/GgkUyrIqoBaXTkgAVzP2aNqAQQlf0JjOcY1CkHUKsSp9T
         +DLucLuiJYE1y2E5/vwnXRMKcMzsBG0UuRDNpMVIx44zZC6y+yje7HTw4kiB2N4s/dkQ
         6rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664468; x=1790269268;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9r+Nmb9u1of9YV/2d3L5W7crVXgzglxIBbWntwiFrig=;
        b=mXoyyCQG2dKHsG34j/e6yABrQq3escJkpMNLkABrkXvW4zChJYbU85oa8CDpHAzErQ
         cZDXBnCcjGytk/K0oAuu2yT5Gl8mDewsvxQASdc93icE8MIWPh9+TfcQi+Nt4PuwhLdM
         38WQCgmTSIIwts+ajV+KoEB741g85FKkCLwDONzIHkY01mGr/J8yPoXRqHtrQifQL6i3
         G04JTEd4nPE6vOS3xNqiBuZiiOuX89S3gBDSww78rrkjEQvyhsTGgFTpD/GzY8Epwar4
         7LdiPHmyKG1bOFScPUre3ub325d3wNNEi4ONQ+0px3YvUwFLFASNJN9JE9Kvt4MRA6yR
         ytVw==
X-Forwarded-Encrypted: i=1; AKwUvBxPYU5YOYxz3RRxf/JNE7aOmXRegtxJnuWNFEnb6px4LyJbV84xDnWs1naQrHO61+RIkZe1iHM=@vger.kernel.org
X-Gm-Message-State: AFuF++lNEVGy1+hiQD8n1Phx/bWIDrOckth4I4cbiTUKS+Ue8ycBFLLk
	HyWySBsTgfrWVdk6QLaxVHJjwSSwQa0PP9nIjGlNgDlnm48iUZSAfvDd
X-Gm-Gg: AYBFou3CelLnzULixWBuIclxZVCLQQeKi52ZiNbo0kPxbMMxyEr7HzjGGS9bX+tvFIa
	l2fKS88O6m7t9rfBPtMgC5K4UBLyJPi09gOD3HS1vSpzOykvKEGRBYV+e2Q0wlKphKNtcNTlawF
	aSQN2ga9HquTdmNzPMru+YzE353MjI0ld1630KYM2q33hxaRZeYaOkjp3w/PzF2pDv/zXeMrn8h
	PHtckPfuXOZQlBBIYQrAm16nC8Mi+J/WpcED0fPSGtgOshytgeFJHTCjUomFmlwnQorJk1HKQ0B
	0B2K+lDOAtv3Poa1LIeC/Kn4+ItE6YEbx5LvJ4qXsNQVBDaN4SSpzH1QIxbwMmLzVnZdbfonX6W
	ZiFtsv9/+U96M2U32ECSNZhX+aR2qW33n6JeJe8Ii97rLdUvQOJ02CTowYGNYw6idMw+SpefbaD
	Pi7ZieehJpT2M4SE/C916CHeYYeN7kgYBE9DFYiMNGV4cOxZwie5Dw5W+5IfpUl6zQvE+ItT8Lx
	56wui8MI3SIsoJDm1OCqWVUKADavlBTjDCxTmYXnxi5QQ03VKu5cGn3u9r8J8iR9GReJvmLw6zX
	CFp7
X-Received: by 2002:a17:90b:544b:b0:39e:359f:8539 with SMTP id 98e67ed59e1d1-39e359f8573mr16938434a91.15.1789664467801;
        Thu, 17 Sep 2026 10:01:07 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36170735sm5918501a91.8.2026.09.17.10.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:01:07 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 17:01:06 +0000
Message-Id: <DLHR3TXGGQQA.35NANUU0VNBB2@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <xmei5@asu.edu>,
 <stable@vger.kernel.org>, <co+ac0a8c41de69121d@bugs.sh>
Subject: Re: [PATCH bpf] bpf: reject dev-bound-only programs on other
 devices
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bestswngs@gmail.com>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <20260917161335.1020405-2-bestswngs@gmail.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 12:13 AM bestswngs@gmail.com <bestswngs@gmail.com> wrote:
> @@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
>  		return false;
>  	if (offload->netdev == netdev)
>  		return true;
> +	if (!bpf_prog_is_offloaded(prog->aux))
> +		return false;
>
>  	ondev1 = bpf_offload_find_netdev(offload->netdev);
>  	ondev2 = bpf_offload_find_netdev(netdev);
>
> -	return ondev1 && ondev2 && ondev1->offdev == ondev2->offdev;
> +	return ondev1 && ondev2 && ondev1->offdev &&
> +	       ondev1->offdev == ondev2->offdev;

With the !bpf_prog_is_offloaded() check above only offloaded progs get
here, and __bpf_prog_dev_bound_init() already rejects those unless
ondev->offdev is set. ondev1->offdev cannot be NULL. Drop this hunk.

Also drop the "attacker" wording from the commit log.
It's CAP_BPF + CAP_NET_ADMIN.

pw-bot: cr
