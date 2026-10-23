Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771365;
	b=ZG7WpdqLvpPnD6lbB8oZQEMxlOaWSsbohfjdN4swKy4eZZwkv88pvZbnuj7ZXaqNfeVM
	 jnPew8sAqcy/6YjVHPR9b7uH08DHKCmWiUwYzmBlOIzv0XMBn1WYfY1HsItr3AugOU+la
	 BI2Ctdxh+XGmv7pq4LVTeakjUMpmYV8xhiiMevpt0TYaVJhp1gkCRMJwhrq1Qsun6G7Te
	 fQHEIApkZxwivBTdiYxrOKPtOsPqhBzI9N250DuSOnezfTO75PsMCu5hwf9i/0foGv+KX
	 +c0ZMqEn9od9JT0kot1DAWkUS048o5BYhg2fFrIpM0VLsM1Qk2B3XYTIHFo8xQZ7TsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771365;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Content-Language:To:Cc:Subject:Autocrypt:Organization:Content-Type:
	 Content-Transfer-Encoding;
	bh=TKIxHOQFzCfvB8JJy4zqkrCMETBIKyn62Kt9NUNU+bY=;
	b=y3a9AgzLB8D6k+GaTLMoX8RBOpDJ0aKJb32k/ISPSOk3grObv0BGJhVmxQbwNllQbngl
	 km4p4W0ri9Y0eGJIlbvNVRNgKdc+jNV15Ri5SknFsN8FZuoLcZz3lqUknT2RPBBVDyqBa
	 yFUgkq5lTwpqh0brbR8bhGTn6/JyGlwto/UrfPX/K0AJnBwuJJPzmchZpLssNgX3laMc7
	 ACILE2tFlC9vdNVOC/JbhN2g2Zlu4BA4zloMi5YKYoWbh0nAAYomF8MnmxUN59mw9ViBM
	 1oPL3qILa8Xl6MeS7ejZfXeT0qH6tWVO/VGKikb4LOEFW1zuBR7dEmu6HJCeemB1KHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aqu1r679;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1276606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aqu1r679
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EEC1F01828;
	Fri, 23 Oct 2026 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792771364;
	bh=TKIxHOQFzCfvB8JJy4zqkrCMETBIKyn62Kt9NUNU+bY=;
	h=Date:From:To:Cc:Subject;
	b=Aqu1r679Q0ekK1sHcdi9ppMOWrQIbHE5lE537100B8Ov5N4AW+SfS9/zgBusV8Yqx
	 lcIGOMp0nn3QbkbEJEWOff0/AHf+uqHgt/2QszvGK58cdJE5phTTHDkZuCDyyAovT/
	 R17rMMV/9nQfpo6jU5iL0mIruhR77aXDYrDga/O+ZMnyy08DsCcIqJGniK5/iAQtU+
	 fkkT+jg0bYOzxxPDBTmcYtCu3TZm2etH8S4C00ehyza67jSG8iFH1X1n1c+4a4KcrP
	 jNrSBvNZbaFHMjm9OwhobRDXLFV3xem7bCvHqmfFzTFAxhIZLDMc2lfSM7aALxyxeM
	 L6SClOw9JT9QA==
Message-ID: <224334a7-150e-4794-af72-596c3821558c@kernel.org>
Date: Fri, 23 Oct 2026 18:02:41 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
To: Sheena Mohan <sheenamo@google.com>
Cc: Willem de Bruijn <willemb@google.com>, Netdev <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [TEST] Google's Netdev-CI: a few flaky tests
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sheena,

I hope you are doing well.

While looking at the results on the Netdev CI for the Google runners, I
notice some tests are quite flaky or constantly failing. I marked them
as "ignored" on the Netdev CI while this is being investigated.

- IDPF: psp-py started to a month ago. I guess you are monitoring the
  results, but then if it is normal, it might be easier if you block the
  known bad tests from running on your side. Just in case, a few links:

  https://netdev.bots.linux.dev/flakes.html?tn-needle=psp-py&br-pfx=net-next-hw&ld-remote=google-idpf

  Because the previous branch didn't get tested, the regression might be
  due to the modifications introduced in the previous branch as well:

  https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-09-23--16-00.html
  https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-09-23--08-00.html


- GVE: "queues-py" test started to fail recently: I *think* it is a
  regression due to the following patch that has just been dropped, but
  we will only know that in a couple of hours:

  https://lore.kernel.org/20261021155611.68473-1-phx0fer@gmail.com

  https://netdev.bots.linux.dev/contest.html?remote=google-gve&executor=gve-nipa&test=queues-py

  https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-10-22--00-00.html


- GVE: A few tests are unstable for a while and have been ignored: do
  you mind looking at them, please?

  https://netdev.bots.linux.dev/flakes.html?min-flip=0&pw-y=0&br-pfx=net-next-hw&ld-remote=google-gve


- IDPF: sometimes, it takes ~4h to run the results (+1h to start).
  That's fine because we have a 6h window, but just wondering: is it
  normal? (The GVE runner seems to start quicker, but I guess that's
  because one is on bare metal and the other in a VM)

Thank you for your help!

Cheers,
Matt
