Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35246283C82
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257565; cv=none; b=ucy392srfb6Wwij6s4U94AJ7HuwK/NB5742p13nH/mybMYkHzwGULzCUZNaYWHmaVTEZ8S/FtAD8b7K7woKK355IX8M2hTM8E5atdN645iUur8XOa7964yEJwf16I3CHJymPKUyAf6b1bnM9rQAs7p76Z673BlhpjjEKBIA05S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257565; c=relaxed/simple;
	bh=bH30D+S77L+76WV39EC2xqLQPjfmUJAx50Hb1EuxO/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3mfXvKAmF1c6mK9hgsEoRXSkRjdSeQXUKR9Ro99h0l0hHP6qLsBkfDE8sRXC0yG5QBPprtiIUaN8xf089IWqtFaIgm1TwS77qIS/m8VQnrq9ZPLW/aERBmtDXmV0R19l6F1WDyE+BMFam8qyDUgvHrUs51R6inBaicpM0lxgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iEKJt+UP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iEKJt+UP"
Message-ID: <abbf756620742f7508d4306b5d830bfb59cea607.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776257550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bH30D+S77L+76WV39EC2xqLQPjfmUJAx50Hb1EuxO/Y=;
	b=iEKJt+UPHhtGDw9Q25fPepjFpg8PAaDIa4DQbc3IFP4bfFh1awzbhgMM1HrnJ0Fg4bDAn+
	iu0ymFU2fFbJghkwuJIhjmQgwXWwB9sLEDic/V0KJmeObxeSzRzDPFarQJt8gJ8PHL7Hhc
	yQUmEzzD5PCJtNUWfuilgFA7gDf86F0=
Subject: Re: [PATCH bpf] bpf,tcp: avoid infinite recursion in
 BPF_SOCK_OPS_HDR_OPT_LEN_CB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>,  Kaiyan Mei <M202472210@hust.edu.cn>, Dongliang Mu
 <dzm91@hust.edu.cn>, Eric Dumazet <edumazet@google.com>,  Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 15 Apr 2026 20:52:16 +0800
In-Reply-To: <0b3a3a41-f709-4414-8a5d-d2eb4959db3f@linux.dev>
References: <20260414105702.248310-1-jiayuan.chen@linux.dev>
	 <42c1fed84a84519c2432163aa46f587f2d624fef.camel@163.com>
	 <0b3a3a41-f709-4414-8a5d-d2eb4959db3f@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Wed, 2026-04-15 at 09:47 +0800, Jiayuan Chen wrote:
>=20
> On 4/14/26 11:37 PM, mkf wrote:
> > On Tue, 2026-04-14 at 18:57 +0800, Jiayuan Chen wrote:
>=20
> Hi Martin, I saw your patch. Your solution is better, please ignore mine =
:)
>=20
I'm not Martin, just same first name :). Ok, I'll continue.
>=20
>=20

--=20
Thanks,
KaFai
