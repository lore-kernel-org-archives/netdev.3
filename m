Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA852F8EAC
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187455; cv=none; b=Z1lcqBl5QGwsNJBG1KzmHZYKylSRkA4S1m8bBE2/IuziKPzp6/SmdLsqsmz0gpcXgPiycgZkSttQuqKjhSitcALFFCTpsbUWGndrNKJdXK4kdFWFkCGbdoDYrmD9U8nSoNWCbipIwcCpKXlLiX7VOEbXCIeptjXY7qCEAzYDEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187455; c=relaxed/simple;
	bh=t80X5BPUGmVpO62XoQ1ic3S9abIWlczIk/GA+oTjLyQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=joggVLrJR3AP04uED1AecTdv8J+TFoXMB280n2sf8yv4yHI2O/yzkJcmoKBa9bUm0oA+K4hPak4qeYM+/qb839mSd0HliZfSL0lhbKzIehHcvLm3Zow/GpwWPZMbWRijs4mbVLNiJIesNYvQyTXNRQv3B4tjWmhs84m2IMzfxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=R/Hf/hdj; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="R/Hf/hdj"
Received: by dvalin.narfation.org (Postfix) id 3195520DD3;
	Thu, 07 May 2026 20:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778187445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDJLEQFq4xW1obvMFv3XH4Ldn5o/0Tg+hnOb+zRZDEk=;
	b=R/Hf/hdjw0y+UELP8T3Fg+VxzucNzyg/X17+ck5ZLPs28DbgX+un6i6Fb+cB3JHbmWcMHX
	NjHOlyGmJqHkK4yUKl7eYAiuWTmRpdYxqIWGf4RKyA9bk4OszQxldYxcPbOuiTfFG74AMn
	w+RdTl48V6iLnm49OZg/Z8kx+wZ9TI0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH batadv 1/1] batman-adv: fix tp_meter counter underflow
 during shutdown
From: Sven Eckelmann <sven@narfation.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
 sven@narfation.org, yuantan098@gmail.com, yifanwucs@gmail.com, 
 tomapufckgml@gmail.com, bird@lzu.edu.cn, rakukuip@gmail.com
In-Reply-To: <df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com>
References: <cover.1778118303.git.rakukuip@gmail.com>
 <df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com>
Date: Thu, 07 May 2026 22:56:49 +0200
Message-Id: <177818740941.228652.6887332849423368018.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=sven@narfation.org;
 h=from:subject:message-id; bh=t80X5BPUGmVpO62XoQ1ic3S9abIWlczIk/GA+oTjLyQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJl//szpFZu+Mcjk0/yLfLVGy/f7PXjbcnxKdceuMOdb2
 uz6tvUPO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATUdvG8E9hmtmmuCdxrqX/
 55jI1a25acnWeqxAid9sqX/JjY8HLzAx/C93OfhK0e7je/bs4Ffbf3y0PjJnb4S1dOpBi/32i7r
 PvuMBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

On Thu, 07 May 2026 23:49:46 +0800, Ren Wei <n05ec@lzu.edu.cn> wrote:
> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> index 2e42f6b348c8..4c582443f67c 100644
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -435,7 +435,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
>  static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
>  				      enum batadv_tp_meter_reason reason)
>  {
> -	if (!atomic_dec_and_test(&tp_vars->sending))
> +	if (atomic_xchg(&tp_vars->sending, 0) != 1)
>  		return;
>  
>  	tp_vars->reason = reason;

What about:


	/* ensure nobody else tries to stop the thread now */
	if (atomic_dec_and_test(&tp_vars->sending))
		tp_vars->reason = err;
	break;


in batadv_tp_send()? If shutdown is called and then batadv_tp_send reaches
this part, isn't this also ending up at -1?

Regarding the netdev mail situation: Please don't send it to
netdev@vger.kernel.org directly - they want us to first handle it internally
before forwarding it later to netdev. This should reduce the patch volume for
them. There is already a change to the MAINTAINERS file to remove the
batman-adv paths from the NETWORKING section (netdev@....) queued up
- but it was not yet forwarded to net-next (and I am just wondering whether I
should ask Simon to directly submit it to net).

Regards,
	Sven

-- 
Sven Eckelmann <sven@narfation.org>
