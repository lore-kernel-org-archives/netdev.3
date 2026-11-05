Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898447;
	b=ig1d91XYHf/1oTTaG93RynmxoTIJkKIGzBshO420dM0EzBHFMLMJumqHCWm/Odq+rHy7
	 +qZgKoG14CS7/qe4WtGIYxZssxpfOEDbg8tyF4cabCvTW2WG2QOn55hQu3hPcTuIw/SPC
	 OheeBcRrbJt0rNXG5tCAdN1etNN2RMtYdcZgzSdK5ifD3tcNsZPMLIdiwx5xkKsWqwdKQ
	 98cApT1aplftsHwr9I+pQ3y16y4cgmuansMc80fyItJUC8QZbymFIaJsO2BQuY90FIJb/
	 b941875kS+enm8wDFHJD13btUKJk2nAROFlxc4dS2jKRtuUK2CLU2fSMPcD/SoSN2yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RDOVG3cpKCfgE6B6tnKo2t7K+1619D3zF9SRV6224FU=;
	b=4WHUgHst/nd6V4Jt/U1sXJ+cPMYNz3BumZDNdmj1PraQuRnv0xJAbQQpL0Z3t6wUtqD7
	 tcJZgII1LqVvjC1D3E/bL0mSFVDybWdG/ZJOt+YIuF08URMrLgUvQcHz2fZfeGa4osk4P
	 ZkeXMsnq4XVu4EigkEtkvGhL5B/jB414FQTzXz0wTEHo+wAHtba5GKB6h1EWGFCyW/kNT
	 bWu+M+WNoLxBIEVBxUFLD4e/p7+nkzyBARvZMb4YVJBF1yFHJ+2tt63VCfWw2XylPHUnn
	 hqrVqL5HS9m0skuXbu4bQ/JlAI64x6b7xM2VROoWXBsiDFZjjr1lKAoCNgVb4lK/RNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=R0jQ0Mv6;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A25606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A25606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=R0jQ0Mv6
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-943e8d35f74so190445085a.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793898445; x=1794503245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDOVG3cpKCfgE6B6tnKo2t7K+1619D3zF9SRV6224FU=;
        b=R0jQ0Mv6Tt2wdQgfQpY4Zah4vKPlzSzNJeN9VLU3IwbWi6Tcfu5CXaOZEoxhGURNKF
         GwBiFgy5HZ0UDyGkFGiV0uExMbWDeQ6kRLLM9opqnAJN/v6+isOSn+Cpz50n7j0Zv79D
         goEZ6DW0JlEZtSH4X5UjsXPlyNvtrpQxqQ6HdqposZjEAumTpcyWQEtjaM2E3HW2I3n9
         ZP7OySFjoFhIZtP4uclXe7kEosPYpdbI/+H+ih/1WXRzFnSZYipuXtPZeV+hC5nHcFYr
         9bdSfIQZrxVwpZXlwWF5iGbVc6cbDQXE7WUQG/TKAuIkgganFCp4/+40SckGG0/fD6at
         3Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898445; x=1794503245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDOVG3cpKCfgE6B6tnKo2t7K+1619D3zF9SRV6224FU=;
        b=ZEG0b/pTNsZxn7lv4GUAvRM5tfE7wltAoD/kcZmyCA1JYethBS4C0+x6vth2YZz5Qt
         mlRNnHmKzfBQEpVc3wRIz52EMSxjofgqlpizzy0ujc2gKBYZswhPZt/+Jamhq75+Uufi
         D5EwtfNxt5G3Hc+q7cvkJ6EkvagPJt1XFtgXpa6Cz/GbK3gWdPclSN630eH4D51c/vbg
         V6AcxrB5Wd6JlKyykF0axgo3TIBz+ntCzcc5ySBgBkm8fhPFVYRb5/9e5wfKA8SaTIaw
         iCmZ9GHhT+E52XBcsHLqtMrELnnlBM3QpL0sCVHvQidfckxHDW5CKBN8rjBOJdoRUGw/
         o3KQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDQOqk+0GxsQXVuNN2oezmz8hs/cjGtuz3VOQKjBCCktS6YIF2t2MG189BC0jW04DCYr5YUOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ibYuE8MHQ/Fh/PyhkM9qvjB4L91DrDQzN/eXzlnkmktpjEclQ
	KZh5R/L1WzhHMKYfRZA6MDXO05P4ddPL2g40jbpQ9Hn/cpKHPtN3q1z535leSPAOeySezhULlp4
	ONfBC0BOITcabbaIcXuTvGyW2EEpZFLxdNVSK
X-Gm-Gg: AYBFou0hKc0dRz4CSnEGtsipuRJKh/YoMz7BEWb3fKw9Vhh82aOTTnYEbvIuOqfAp0K
	vcUYOFN944DNfW/fkrRiLCMqT78KVBPt22Lt8maUBKiN15XRi3mND0DNwwxYCKRADSEIcRnFH77
	U+uuqtSAsdFd3ocRD/T4CFgJPvv9gOGD0sn1vj53JOXlGbXVXygvIFo24J+26WwdeiDz3dL/TFx
	/sXCITgsiva9ikX36Yf6Jd0HOZgOGy4yDISYaC+GOh18EU8kBeqm8JpV6ujo+ynyKGJz//CYMOL
	E1CRKSilPfi1P5XTGvnEFbrpCz0M9fOo4ovn2KwgPznZVKXIHdd924Dd1bO0Kg31soVrkTOGDBL
	cQzk3nEv9frBHoej4HYqh+rtJ/Uf3OBXUxSit2Xc=
X-Received: by 2002:a05:620a:2987:b0:93e:623d:99ec with SMTP id af79cd13be357-94421744cc9mr3322483085a.13.1793898444949;
        Thu, 05 Nov 2026 09:07:24 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-945d47853ddsm65531985a.8.2026.11.05.09.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:07:24 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 41BC634039C;
	Thu,  5 Nov 2026 09:06:53 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	cel@kernel.org,
	ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	slingappa@everpuredata.com
Subject: Re: [PATCH v2 1/2] SUNRPC: add request-scoped disconnects when cancelling tasks
Date: Thu,  5 Nov 2026 17:06:53 +0000
Message-ID: <20261105170653.3200815-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b9ed2a8b5f687d7f581d4867a7867c5c012bb2cc.camel@kernel.org>
References: <b9ed2a8b5f687d7f581d4867a7867c5c012bb2cc.camel@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I'm all for optimising where it makes sense, however this is adding
> another spinlock protected section in xprt_release() for something that
> is clearly a rare corner case.

I agree about avoiding the additional lock acquisition in
xprt_release(). I should rework that part.

> So how about something like the following change instead?

I tested it with the same reproducer, but I still see the reconnect
behavior, without a noticeable improvement.

I think there are two separate issues here. Counting only successful
cancellations avoids triggering another disconnect merely because an
already-cancelled task still matches. Cancelling untransmitted tasks
separately also avoids disconnecting solely because of those tasks.

However, when cancellation of a transmitted task succeeds, we still call
rpc_clnt_disconnect(), which disconnects every connected transport on
that client. That can affect another transport which carried no matching
requests, or a replacement connection generation established since the
cancelled request was transmitted. Neither RPC_WAS_SENT() nor a
successful cancellation status update tells us whether those connections
carried the affected request.

What I'm trying to do is limit that blast radius. For a request with
rq_xprt == X and rq_connect_cookie == C, cancellation should not
disconnect X if its current cookie no longer matches C, nor disconnect
an unrelated transport Y on the same client.

Would retaining the request/connection-generation scope, while removing
the additional unconditional lock acquisition from xprt_release(), be a
reasonable direction?
