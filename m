Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB337D11A
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570907; cv=none; b=upFKH5+S57BarxEXPcaEYSdOk9/WiIJYz7v2i6dZ/qZykY53ybbiKFe21fJk+4FIjrgHjmHkUJnXcoVp7uqADFdNRzL/yJrT5cGroRcow8ogom9WP+9VcBa0n7Y1kTkzlnPJeX7B0shajB+qadofpFLQTcVO8TQmQBT+79k/1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570907; c=relaxed/simple;
	bh=iFOavfqcbecw7h/v32EEfxZFJOc7LOr/gGBeiIbXWio=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=u/wREeEov0q7ty8fkKQIZk2HacS3Dqshir8YfeOoVJQsTC4pcOcT8+tYFML2jiZJWmNrymzczcnz21aVHJPUZG4/4Ll0Q8dJFuCfcsovgihtueZ4NucUTY5iZg3iKuPzj4zJ0dINvgiJqLvLPbQAO42/yqN0oC0eMepQFcvZP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak7Ph6o9; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak7Ph6o9"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4c6545d0f93so1289653b6e.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789570904; x=1790175704; darn=vger.kernel.org;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iFOavfqcbecw7h/v32EEfxZFJOc7LOr/gGBeiIbXWio=;
        b=Ak7Ph6o9vgvSZLlqVzVzu6XID+moSRD7UXs/4QFIo9OmyEgKU6Xcjh5e15azetDpoj
         7hkkKrDdz2ndf2mgozfGUn5rVW7l6eBKguN4ydMW3g8XLohSTsnPegteKyAXnpRutos0
         bm0N4KWm1GvDMsxA2bT3B22v6ZUNaf+Qz1TyDAsMkLVQcPgFM3uzLfkzZ/2f6VtUovH8
         BBTTbkZnJvMlbaZHQO20mLcVwEXYBWom32QMs1uwnqaFie3rqmpe174ppnI/8RwA/vYr
         nLfAqq2waLWbhvUuZkVDPPxbSaE0ObNzWlL6Ok5aN3APYMPwibfUX9DpPq6XxLtlZlmf
         j0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570904; x=1790175704;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iFOavfqcbecw7h/v32EEfxZFJOc7LOr/gGBeiIbXWio=;
        b=t1LzMihbnrLeZsuCG5zvRYtxnssKLF7wzVNO4+1ij6UCpH+m8rlRxsYAi/i7PMPK6K
         PHamW5YSobal5hZsOnWXUoW1U7LGQmMn6oCiNkDIDgZw2jwDoN9Kb5qBbL71hCb1cKmT
         p5F6n7Ph6b+arsoQ8Gds+LHyRuOVtcrlNgc+tgFCM3f+GSf1jT3ZLdEISkkEyiRwYrQq
         AsZwdN3utp87DrakYuwWqV9hO5i3l21FWfW0o+yJ0plW664BZCBJoM8k2ImXcX5ZhZx6
         lz/zfOPzGNY4aloirLV1dke19aEI5Wc5nvxCDPk5mkuNBzIG5wJCxfmEq15Keawnkb3D
         ZMsg==
X-Gm-Message-State: AFuF++numoMDEaZXA25VD4/3evNueBqNFa1/7SNNJfqNT92+BSuh+mMF
	YNY0QE6JyrzlBQMjNfUqB100tgTnPyfA1wbBa/oeotcfirxGw5+B466w
X-Gm-Gg: AYBFou1uB7tXHs71DW60cIE+gI8+ZiRHrMzVad+p2IfImqpDhGum2lLlTRnD27VykMq
	JIdKuqn79WSHqALNmb7WGRprV/+zi7V2ee2z9RRir2e2IXjKaMcrjwmFkjz9VKVBzpj/xdil1QU
	v8dR17UgVIO6Q3jDvQjRK+VoRvcY8EriFGIPEawIA6pAfFiVlsdE3BaSJiWGnM3gjEVR/C4BhhY
	gaMkS60oLjKz2IU7l/phYzETpaD2mtI0rsdDnrt8x04mSagtZ1gZrniBVX9SZ0IfxKqNKbi+OV7
	VsT0qjiFfj39/OVcm5T0zo0VgYhSKGdy2lV0LKhFLGhuQgNdSOvaawPPg36hIwJ5LxkblYLb2p/
	O9udW68z5AYh4GsDot2GILz5ii2oAltKY7dcajCCFABcCA1WaSMLunSjnA3kBhJyXO9vU4SuX7k
	m9+O4ITPamEIRt+TsFi2a9MvB+cEykUkA4eD1npTT8xG+7cEDSN0LAnhC/PUy6dFE=
X-Received: by 2002:a05:6808:23c6:b0:4c3:b290:cf55 with SMTP id 5614622812f47-4ca49cc9e69mr3688999b6e.7.1789570904339;
        Wed, 16 Sep 2026 08:01:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50aa986a5sm1797820a12.4.2026.09.16.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:01:43 -0700 (PDT)
Date: Wed, 16 Sep 2026 08:01:42 -0700
Message-ID: <756a472dad0f5f5c89e634fb8290b867@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, linux-kernel@vger.kernel.org
In-Reply-To:
 <CAHS8izP-gdUcgn2OewUVSWYFWKXrkWxhavPT3=4GwoziekHi7w@mail.gmail.com>
Subject:
 Re: [PATCH net-next v2 2/3] net: devmem: embed net_iov_area in binding
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> Not worth a local var anymore tbh.

SG, will remove!
