Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5237FF46
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235387; cv=pass; b=q9oGm2roN1E3AlX6rwHTaKQr8RmHLG1ZoeBCsCdWmKwYHnowKiYqO1pQFVmfO2CHtzJqMJxLc8Q1Cy7H1GH60YsI+5TvU7BDzkXMqRWEgXy7l8b/6JoVwF7unudMQM0D1s7zRSak7+pCGHiehuoOvgEdZkzNKkNIn2W3Jv3kxWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235387; c=relaxed/simple;
	bh=g9aTtVcv9LERy+r/7+jsTWKc9sGUdMvdKz9/1Cv/8/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MANx1vevVwZSb5PVa1/3iHCz6bCGoNw6z+bNvLjcu+Fn+gDzDapDsahY2MxinW+azaafIuP6T2HtHq7zCMR5MUBYD5YTjQSh8d1m1Ag6v8ULmWYj8Yx9PkZjl0IWbPOo0IbpE2eiILKpsGMkwETTUc7bsYoz6ovmamCyZGQYr70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dh0+L9bW; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dh0+L9bW"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-826fc84df5eso903550a34.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791235384; cv=none;
        d=google.com; s=arc-20260327;
        b=SihMOJiZXx6qUAunZ0rV43pc8XDbanOO8K0WSAUFcoUpku3R9glJAIUkHogNfCBPM5
         dnAiqrPmc1cQykbUev4K34cJx+nRUAlUeLXauflnDUTIsyibKEYWvtRUwWhXaqitjTet
         VFmS25g4F9MzgLnfyoEpgZ0oWjB3lfBF+QxUsaAmNmfQKar0USEZRYvhmM3fXANbDTbI
         JsXbrgR/GiWj9RSdYRdq1GZBHwNWMEHZvh6CnAADCnIZY8s0rOi38hHd5kPueThTtGSC
         KO+lTij4ty5Bn8BsyK/DeuB1jfkNrBFa+Suz8wDtaZvuffxP7lLLq8bYKha+dAMer/lQ
         d7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g9aTtVcv9LERy+r/7+jsTWKc9sGUdMvdKz9/1Cv/8/4=;
        fh=lafM3K14rnvNkRq79gtBjwQKGb6uAE20szNquhFBMF8=;
        b=QJSthxHCDhMSZIVrgjTz861quNtD3lnz7ORvSUPEZxdZth5dJNeKlYpIzXhTpmovyA
         UL9rp+0+AQ6EUZ5qd7BXzpERWjMwGwjBsg4CFU8bHB2UCzY1SDItsjK9cd0ldcorZJDJ
         yaAoBr9O00JYmWCXxGpL1ksYZPgfuHpnNl9QKWQ6LVUKhwL/VEROCiFWhckchNQak6vZ
         mx14MFun4ziHVRj9u6ZA5IU3nCBvO/EEScUkJjtNaDcxE0FfAEAKW88zmYk5kmfDobl1
         x6Ct55n3eUzvN+H/n+qEw4DjiW+mg7zwJii/0Uh/+86hYP0jFc3R3NJqjek3m+3yEl12
         bgKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791235384; x=1791840184; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9aTtVcv9LERy+r/7+jsTWKc9sGUdMvdKz9/1Cv/8/4=;
        b=Dh0+L9bWXRV9f+RK/dQIJVo+kLv6w4nCPBRXWYCOY+23L105Kp6XQ11EmTaABaj3qp
         F0qIISSu9AtfZx9ZDbTfi2fnCuxfWaQ2wWu0HsAgQYEO5F5ZOp7ZkvgcrIRDKpoFswUU
         /QC46o91UO5414gMYXDmnBKf6pMc2DgYlR0CC1tlI8b4KLm1YcrPMqoADaA1lhrsn88p
         5Vle/6Rmbg+GGC8k+IgzgRKManPuDSt6aIPo/wIzHOKhRi4qGkimDwuCivYd6aShjXi0
         i41+iWb72+mGo7itgMhcK2m4gV+2UNefK067Eh1zLba2DkiKtcCGfE1DAyPfdiV0E8TM
         /ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235384; x=1791840184;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g9aTtVcv9LERy+r/7+jsTWKc9sGUdMvdKz9/1Cv/8/4=;
        b=zPswb7VgqwZg2UkXJ2yDO9G/QAImwvRD6QncfkMgJazrPnebOuNGqxrkgM7iDInOCh
         AwA79MpE0pnujWAzqFOTCqnAEkR6dK5LOyHFGXTsR7n5142+GFgPW4JzpUczIUxCTEC1
         Il6C8ZrBrMHPbS41brw05EiJHuanWyGPggP+UZlwzolUFrlO4xdWN4JM7k9gRP6FJLdK
         OYrJk3ncZ9LM3Zi6KjFraSIyFBJK3qHiPb9YYeSzNlfRPpeOMBydjieMPbg4180TnLXQ
         dGDNWXW9MF5hA2we3DBJrx4jmiwOZD1s10OQ38OwUtqTxMAG3QC9QcSTSzdSPxUBsh3a
         rv9A==
X-Gm-Message-State: AFuF++npxh2FiwCwSc4qDVehoJOQ9hl57gkieAaPKEEeYuDZhQyR1PhI
	7HVy2T5tGN7IQIB4JlUY74HNH/0BtaEgWG1BILOfdr4UAJ8nIRBeyytBry+1qwccgeIkUxhG1Uq
	EMH7hvNUXFdWi90u1Pf7ba4ek448r7EE8+i+/eH7i
X-Gm-Gg: AYBFou3GmQV7cFefWQbBNFYc+DR2nIT1tTtroQAEzi0EixrUtCfR0t/kC5yrHj+abtw
	y3GJMFTAHr4vafVsdyquoYOnA9hdFXT+4DXKRNc0USToE5S2uCljAL3Sjhzpcc3Y63EB0208dfQ
	qharAIICRLnPAORRU4pnwk/rT2y+tbanrCHva7W6o0G5B/jTRhfgzpq2zBs2vSpF6mqibiQBbux
	89jIBxqbn8N2RGyhF6x276S12n4wCMEDF5WCSoFRJubM9Qr2Dg1ecU4ir3R7zSq5NS+ygJXqYqt
	W4jUvfFNDSIgx7bDYd5i2mFjgxdP4fJxSnuFImUHLY63a/X7AJWINgQ8YxGIOB7cAXucwqvfWoU
	zJ6QLRa0wCgv8zQ==
X-Received: by 2002:a05:6808:1806:b0:4cb:f21c:a79f with SMTP id
 5614622812f47-4f52a7804b3mr11596483b6e.39.1791235383765; Mon, 05 Oct 2026
 14:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005210403.3206872-1-kaifengw@google.com> <179123459939.1402591.14198806382912674675@kernel.org>
In-Reply-To: <179123459939.1402591.14198806382912674675@kernel.org>
From: Kaifeng Wang <kaifengw@google.com>
Date: Mon, 5 Oct 2026 14:22:51 -0700
X-Gm-Features: AclHuK8G4eay36SpLs-mkYBL_75mcDtYJSdl5WMYJ59dH9FYPErcubMQf24dLjo
Message-ID: <CAKkY-qMu1hmRTGKAz77AqeQ5=bD4D3AmmNH+V-Y3FduiEdUJ=A@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: check uid and netns in net_devmem_get_binding()
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, sdf@fomichev.me, bobbyeshleman@meta.com, 
	kaiyuanz@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This issue was found by the Sashiko code review bot on the netdev
mailing list (Message-ID:
<179007458060.2160803.1077952399417880240@kernel.org>)
We verified it locally with a test that creates a TX dmabuf binding
via NETDEV_CMD_BIND_TX and sends packets from a socket owned by a
different UID or in a different network namespace. Without this patch,
the cross-UID and cross-netns sends succeed using the victim's dmabuf
binding ID; with this patch, net_devmem_get_binding() rejects them
with -EINVAL as expected.
