Received: from sonic317-33.consmr.mail.ne1.yahoo.com (sonic317-33.consmr.mail.ne1.yahoo.com [66.163.184.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC718313543
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761533; cv=none; b=ii41q0FyllIsK1qsYbnYUI7lifb/+6u6ZNADBE7z102iAREbyiEJ8W59UxARtIijnbEjESyj9ma0ZFCZOtDTp90U1e4Vxm6zQgp31w6ZGnXRhO490hjn86AIyYE7SXCBR9Q7IUkw2ZzvSuQtqcdPiI+Aj20oQj51Qg5FZPRKFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761533; c=relaxed/simple;
	bh=EifIRG7TRl9QCR+3eHOvpf1UH+UR7E+QaGxfPiJk36k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qm8J7JZOAQBxw85JlyMR0wlUWiV+K2K0kGnQjx4AoKbfG+O6eBHtDbLAnIgFuRPmoEj5qtu9Tm6BE/ut5jeIZJMzs+IbZZDfGYCTodd/wCmgs8d4p4jRD3tp+an1IKjR1PZOf7s6MMeiwi1FNAIOrf/viLUkTtJM8NnN47ziUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BkAowf4m; arc=none smtp.client-ip=66.163.184.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BkAowf4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791761526; bh=EifIRG7TRl9QCR+3eHOvpf1UH+UR7E+QaGxfPiJk36k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BkAowf4m8TvnzeHH8rKQiepN7G5Vjvj//EanLVk4SHlUOT6pUPl3mnCiGxxJYhtk5jIqgmgDZRHOU1wUhYAeCaXKt6jGjgsWx5TvCSMHqFOZMPA03JEQ75wXzo8EBX2mCX9nczYVFJ8VAOD/oDcdJO3u78YbLjVoq9yiDtz68FDRH3NG0xHckwai4zj+x+jbDVoQVP3hWoto3j5SUpolPS0YX1tw7kPO16M5Jdul/rWZw+o1Ne4QttmPufauuY4YY+cbWaKX2mPmpLJR8CD6OiTXrvMVXH8m54zwU4O1He4YtQvM7kbLjpnhqmVo2gQzGq8v/fai7wheY8fFQt+2CQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791761526; bh=z9MipcyLtU8DFvZPETXJ+LjAIlBJEvJIHnl7oSqbh/q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FiYu5nzY/zdHPKH29lEUbBdC11jvfVzUgl5FFxLbVQj2IzKmXjwsqvUJ6sSnZpMacybJr783Vb2KdseHMdi1858RGWVio2dXGzLKtD4N4Yw6WqJBkCL6oWgQxZqGUh1a+QGTCESpiKGzYOsMRcUH5HFA3fLnIshCOwOQM89utV8oPkW8VwprqNKCeU5P6wKiPk/o8q1WKxYWX2UtTmGlZqs0dIXP+SKvLIg5EN1UNiSXaSPnmTAJQu7/6Q1pCiytO84VJZHksRRwvzZWpKsoyJ9vS6RVtdIG3so14+fzXOJh2E9LhC0MB/zDFJu2vdjiJ7cnDmXGBzZcqxyMS7hxkg==
X-YMail-OSG: gmIgQnYVM1nqFi7kPEEgXNJ.PiWF30XXk4uhPI176574TEu6TbcnGs01un.RTFQ
 kC3YS6bMjC6crWXQGkRvWwz52OoX2YBONXvlR9daMIAEsCE4f7N7wvsu0UEgBexPZZzTRlY4JrEr
 yjohAuvH2zEEbCRW4nl7B9CTm8GBzJ0EQw0JrePOvDO6Sprdrgd2WIxjWr0ONavLNuUxQBUUhMBJ
 vHcXeKWMjbTw5PAEOAno7doEswUpbs6JI4szqrOwVfz36dAzDrMecklt2BeqM8eEtcxOWzgN3qrs
 OCoghKXK.QD1zuYWKHR_QuMQkp0SPIuKlhJubf63skrGHQkz3l_EqR9dD9RFTLS6IY.XQbE6SmrD
 Sdxs3Diyby6ProutwkxLq9v.3FXkj7gvUme.xebGB0Yug4BLBmDHiEUtIF91bKnoLZIYfKF4uEK.
 5SL49oaeDSXnWxTZ1c3NBuPqRtB.kfa4uX7VnwQbpDNtQVr.RlJjaGSK1XVo7Okb1PPvfy_9KOtM
 xQvA9l6ofGRo9cMfXGOKJMJF63YsbIdSn4loWh4pyTYxQPr.hWJAHXa_5u7XsxUbt_6shxGlJ8Yl
 ew6PHEaMS7TbMWZ9yV1YY4yxndZzIQ792N.GqJ0Ue9KoRxzX8hAqoAMlTPOKixCBXt.wNqGlJZ4c
 HgwJSk4rtZo.MZ5XJOHqQyF.OQX9oZ.KH7PWgB7VyChPVGbWbOOsbvSvVHx00xI6XYjRRALsqJWx
 lD6Iflcdeu2byPDSaFczQn1K6cUs7gNU_S3v76TUAtJln.rZZ2W8lLsh2wdZhmzVfH7aaWDJaGki
 3SII7qjeE468TYsGMlvriRhqc0ury1lNMeQn1Oddt5VRk_RUXBUDY.Sc0ekB8A9oB9JJEdsegSws
 ngjgdLZP2DNoq8mk9SAwxRc_JJqHGFTDThGTiBP810DsgcNw7iYXYvhboE4RNaDEWeETcMWjuOzZ
 pK2J41vVPV07ANZxRLm3sqejdTcb7Yj1gqANBdJjs0c9ijEsB7qePEuv6Z0OWf3izSetjHUQwfbN
 hHmBjrBmONjzMABQBV_0YekOXbcQTmxvtWYwvQ53gp.xI_9YVOeOWZc0kCDQVdk_gBjDv8ZYLUPC
 I92v7dSPNv79cQvYEZDfhjWkvckVwMQscVmJ3XUe9E8x7s8cWdNypTZYk8DuV6ZIyQ5micGNSU6l
 HpklO_gIx0L_bgjuPH4FUeOZiU0.R8G2r37FL_6fYX5jMQ1M8C68nu5mMzqklwqGnbm_TaD6HrcQ
 u_0K3WjILSQc2tpDX2uRlfHL85e.3FBjV3M0axrfYlG9KEKLIQ9IATK2QMCJu3.xDlvAcY.OZvbq
 g_DWEMNyWj1pOllV9ly6K4BXpY.JcznjxXXLw.YYc7CR.VXeMGvMfuVzz0S5aXuajqaWaNHTyLag
 aDA7TtBY57egEdbqUTHH663DUsAySG._In94NVpCjkNQ2hB4OPNong2pqN3uU6Kul.cAIWtaWAC9
 GyLmmZ.dWfbOcipRn9bL3MDfIM7PouWRQZbbEyRDvmQJDtUGhyjTonXuHRvKCyxPy50cW4R6eck0
 VTP3WAEZTqsgwy7e4n8h5rwadJeMVvryGT0ee3ONZpI.VjwhGewCqanieIJTUAVlr53glpbk5rV5
 ULnQ4sXu1O7xabUdMf2EFpFMsT5bHlK9ZI3jyq7sX0YZ_6ML5z5XZ5ZwJiI3FVCrDCW9AGgPLnWS
 r5tQJNxz4pA53V8.HB1wgeQ80ppVPuRzEPJgTwhIuBlkwtxa9OmUOQCytbkHyvRJKMi_B668G9Es
 q2w20_7adF_p0Cb7aQVMJXu2G.7Sz3TQIX0PjQA2UxxjGIhV.9Xmofmf8DVIdoV5Pd9wRJ2ftqv2
 1xh9ci0IiglbNUZMAsowmIl0G1H1Wl8G7kDi2nt8Dd.A28PbFvS79FvQa.tC5aeUFjRfpEKnVtIZ
 Yqey.clwHEmxAzwNLufbk.TT6qZ_3R__GxfFhRLJ0RVoP8EnxvMdZ.vPRqItIRgio9netDZOSDoR
 HdAp_ZFLOq0TMF7PZ1FXViSynP_2HengiezimrWAIJOgu.XSo_nC6o7m72JvgidF4M_vu3xBtx8x
 itKE9fXNtgdjfhpyE3ANi4CT9shygi0UIs_1rnI_l8iDD8fkvqPFQPKrSM_9K2gMPIM4vG.w13H_
 KSKny.u6Dr_rX_GOr7k3ej0mTsuCJxzzkYIuaijKDXiXWK7w9_syyWl35Hq2mlMNyh2FdzvJyz2F
 _MN83PyxwvF7oe2on8YOIjjEi577GSiu3LAvBbRcol_Mn.TneVBdSqZibWmYR4h3kg1HJKLRDxKk
 L605nvBjTARUWidMSuYUdqFMAESOPn6WXwZvyYp6hiA3IxZt5etI-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: fddfef25-fbf7-4e84-b2e8-fe767513154c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 11 Oct 2026 23:32:06 +0000
Received: by hermes--production-ir2-5dd9bf4598-c45bs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2d5afcc519ec4465e506c68bbc713318;
          Sun, 11 Oct 2026 23:32:04 +0000 (UTC)
Message-ID: <1c967962-fcf4-4974-90cc-c8a98b91217a@yahoo.com>
Date: Mon, 12 Oct 2026 01:32:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 9/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
To: netdev-bot+sashiko@kernel.org
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
References: <8d3a9cc7-17cb-46b5-ac78-c7b4055989a7@yahoo.com>
 <179174829036.434549.5346764045610555935@kernel.org>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <179174829036.434549.5346764045610555935@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Thanks for the review. The issues are valid; I will respin as v4.

pw-bot: cr

