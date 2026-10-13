Received: from sonic311-23.consmr.mail.ne1.yahoo.com (sonic311-23.consmr.mail.ne1.yahoo.com [66.163.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9C388E6F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881372; cv=none; b=Ntb1YRbQbALLaeHHOeuCpZOVolz+LoYJSV6l6kVuzIKButpGnllyztNWy8mV2n+/Jr3MtvLtl0LmmURYRzMmcB4ZuApjaUeLxWeBXQWM31BBw8NFjzoXWsuyjaU0CYrMsfCkP6PquJ3MG37oI0/BUnTK3NeAVQb3uJz2/kh8KcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881372; c=relaxed/simple;
	bh=ttX9DS0o/jptwxFFB08394K95L92lWMiyk44MlYsF6E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=r6g5aSANm5pHH3XUjdogedQ03Jm9avNPGjEcjctAROSW7CbV1Jf4LKU+b/UxfSFeoJOl1XMjeBuyyzzWtJUo3AdYnHN45qgIGIU5lx+o7y4b8iEwpeE6A5zZvZ9saMgvPYb3B11SEDfz58OTvGpmzdqKGPnCmpm8P5ANkrJ2rdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uIOmbO4D; arc=none smtp.client-ip=66.163.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uIOmbO4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881370; bh=ttX9DS0o/jptwxFFB08394K95L92lWMiyk44MlYsF6E=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=uIOmbO4D7cUsGEzEvMy8Nc5zXqrY/Oju1wzempclZITdRkkkLL7OxrhLEZdAtXdgOBF3GzcWSzW4kcuhAGvzPkTUChr01tIUTwP8GZns50BKKyzzkvFqEDtSs2/WwKePHZwt/2EcHDF8oxFGeyf+DmkGOgfFR+D09TNX2xOL7GmTqPwNIwqriidWFBzkZWdm8DYGoUlNFLG1+Z9Kj0QjGT19af55WifCAlHw9dQ+J6eazzKIUfFogRLhkEMc4m/lW30RR/cK0upILmqWFH+Q3PHpb+7D2srqd/8uPoTTUTW9kM7GYOwibkEuhHjLjpp2YMTtizOIJx3Azc6qNYXZmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881370; bh=6g1k4ETJ5vri/+Lif7Yt1B8KEY65GhNLoCAa9UUVTB9=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=kGHbvekm/luW8VsjUfswKms0itrftEvg/G9BhLaKJ6hetNzpfvStyXPzBQaWXOxvwY4UPHgWNxZ1xpLMd/60Yhp1AA27D7UgTw/loV60pkiJEjfNtWwyW7rtjdjeZpyzmlXPu7HilmoTtZIX4sumWFzByLKp6gMIFs+5cW1CtiogIXifw3mrrmHKUrxpbnKm2cr7nyt4xt9ysomwXrjpk/Yb+KJexfRhhg9OPjQTLRFORqBosBPUQqKYlRBlg21GPNasDrvQWSJ6sLaeh3YgiIFK9CGSPSA6kB+jKUvN7WJ3dEgRm7JJRW2l+6k+Q73ePhF/wfcRCpyVu0eIlPRPhw==
X-YMail-OSG: oOz7hH8VM1lu_vVjCnGU8IKzsehVMTiU17RqKC2.gXAIFDaWC4.yX1mF.fNU19b
 8kHq8LX6hjBKyAKYZ9dZYNhUC9DtJLnz9YoZI4U0mhBfeXRHta6Wc6GzG_dDDEOlUP1JF.9vzzCQ
 vRnbBLStGLjtCn73RrqC2o8d..goOad1ytP5kkMOyjwQ_mWH1_DgyRXXYMGOwgFv8ugrs4fldEVD
 2uCwVH0NgZnE6jUHdYwj0JwkAZDFZ7b3Db9OUzji.N5_SsI66AQMlqbJoCbKIzN3ifNMABtPWg5V
 BxM1mhYfNW1TYbGTEDp4tQB3ckBMSnLcIxGs6XxbjO8Tpdr1yqRM1PFZ9D9maAfz5oHZvapCMc0b
 eGF5c0HvGLSsobJHZXCGPgXqAtYU1Y3NNr642bxRp6pLKRcaf2iJX1Uj6LOFw2kfTh2WizDMBkEq
 inktjEr7hi2qyNIHf_Sp.TmL9TyUdzPHvJP3CNWAV.q9Q2KjVwMpi3yvMyPB0XubGmf51hVkwAIr
 Ii2h6Ln56U6Txu3ipmnhszpGP8TE_6hnc33RZtTMxmZuoXKBxCsbRwK4SBcU4p6qlNTTctrD6yaE
 t84YoVWwLPcrKqh6Rhp0zgXaPXHOWLIWzPPfrZQe8pvxudmTOsp4IE8Rr9xz87.1BkenZScwbT8S
 5iBa1T_dFfz7PNLKgRWoZAV_j4WAhagCaMM6XyP3IBh3KHQuQVOHNOoXGjztSFDGAS15cR021rfD
 mDhUXJpm.WRkxdjaLCwqfnmYMEK7eJNtlMWaiijY0QysHSH4BWrNYRgJ_n5w9x8Ju4YAAwWFmO_Y
 S0aE_iixz.3xw5o4ottD_Xj7KW.9Y_tpiZm7Llq0WlvK_8uh_cSZbdpJniIb81XN3E2Pro7ZmAPj
 b.psMVnxEqUbkfXdrNSsFJoWdBP9sSoJ8IRuq8o5hVQ1ILbfzRHvzOa5mbiQcyR3NHnH63d7fsYY
 ybTnDv6etU1OiojPBiGOEbuK0euyLbbsI5ZHci_I_ER68_f5gU9JExkhCzSxlGuymwVyAeCjRWhG
 UQlbISscIe61M9CgY.9DnjaheOlVTnyGjbke_i1aKjvrJaT3cWsFX3bI_hJzLI5qyOY8MEPJXaxj
 nOokN2_UomFSvnMWCX1roEvserUeVk9dun1uB3TB0yN1VCutRBOWj1EoBxK4aHFgwJs7VDKrre7a
 3158piux_jzbm8brq0pNDRjwOW56vY6tcUc1WzIO9CMiKR9X7rB20SpTktV3gXfy7ECpzUWWdRoJ
 qM685RK698dliRrycdMdaB6svmZKYC4YsKVcsF6M.gD760vrqwHBL68lXxnQdylOXmmIxzjUwaNM
 1TvgHNfU1jYHMg4aU7UzY3PkGaVqnpmwYMW962P3hpVGYipLxiKWZn_p.lO5jDSM4VzIZISMZerE
 knpZzDYSWKdxhivXydHA0f_9_31c81JlZG.G0hZvyTLpZdxWJ9bsqgeoSaRVLIX_uK1.HgVt8L3T
 qG7C1YXuMUAlPtbnXmjbC1UjSPJnmj.OA6G11ucKeyCQMmzo1fTtlKfOmT5aPRN8xBlNKHMZDZMK
 tssUwPPhm5atfZPMQo5oYM2eNQhlUZH2DUhZGkldsNuWt.JgArR6JAwOzT5VcQapqGioVKImuQaf
 gWOQidFZ_nKQtOc3iDozyimRmcctiMKwWx2XeYRnAR7xHiEMH_YFPr8Gzi1VurHgdudOknOwYpy4
 8HCBu3uW2dQotvhExUKL1H50v3ADLd3k.106VP0kVKwEgLTxFt0DMs1JmX508DEVa0ikaw3lybrf
 CXX.zUIQoyLW0VffDYBHFqXG52RFXdsQxP0TZJI75ea2LFwjQPVlh9pihZUn2nZ1CdHkTdIOJeWs
 5Xp1oP1ayEZ_rHdQg0IoCZ0l_yAKPB7iusodCoHUnQWrJ1NEqzGZYCXfYQImt0DQwPBjY2Puo0F4
 foWKcS_6SCh33Jul0t0zchduJZmbYwyaojyrbyC.x93qw437pkvjzEv2NARgtueYqyXil1c9jgGo
 mQLCLafnM98O2QtHxOgpLc9CCwnGlTvgXfFxsFCwkoKjWW8ADJ9zP6pDCDQgNrVyORzAra2GOktN
 3XSOd8kuHBzn5c9S5d01NxEVi3NglhxjNCpsKWh98ImaCRqz7xlXUsXI6gou3T2aB3k37tI2of0S
 vm9BzPj7OXOBfQoeUyjpSboRPHzDPTCCAM.TVvOWxyjnGVA6XpN_5v29x8sNbJQE80LP0lFjacfy
 GmSpxsick9vV.tLoC57RV3WtS4B0xU6I7zi0wAvS3aHmftuF0DNhS08GwljCikEic0CkUr7NPUcr
 bwjoUm3RE6y28ZihKDg--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: f144e665-9088-4e28-8cbf-9fbc81ea68a7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:49:30 +0000
Received: by hermes--production-ir2-5dd9bf4598-bbdwl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b4a801a06fba763608d461897b6b15f;
          Tue, 13 Oct 2026 08:49:27 +0000 (UTC)
Message-ID: <b496a3f3-0da4-4fe2-b8e6-8fdb49e82c45@yahoo.com>
Date: Tue, 13 Oct 2026 10:49:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 9/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
 <ccaab57b-1bab-440d-a4ac-d3e467240695@yahoo.com>
Content-Language: pl
In-Reply-To: <ccaab57b-1bab-440d-a4ac-d3e467240695@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Thanks for the review. The issues are valid; I will respin as v5.

pw-bot: cr
