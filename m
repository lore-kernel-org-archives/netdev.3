Received: from mail-yx2-f29.google.com (mail-yx2-f29.google.com [74.125.224.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DBF53A3B9
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693939; cv=none; b=I+rex5XSUzNC0Dbz+4lWllt6RJr98G8LW/ATR0v1sosfbHiD+2eAHUn2e2BTzoMpWaNdN9ecnzZyTKlPYH54IYajNp0Ye7VNgRDnMVSRl5GT7RRRtD9eAALNRgU+isYy/H4nbJkBoc2hyzJlOq4s9zWek3X8o4B6cv+fR6Iaj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693939; c=relaxed/simple;
	bh=sqsXRXBdLNOFLMGFCpfBJMfaeUhKZCBs8CXGJ9Dd9Aw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qktJNHR0LHys0ZUaUpJRW7Dbn6XRffBg+1iacsv3oWXheTOhUHlmnWYLsJCTG4OieVPRpNWrIy/yAyOYeOwWBAH9Qxy7s2M7dIiFhMUJEg7d+/xNXjinPdCCAigub1UDAWlrzjm5ldA8a0fipbATd7MoHNXoQ5V82q3v0XyPR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOITVMBD; arc=none smtp.client-ip=74.125.224.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOITVMBD"
Received: by mail-yx2-f29.google.com with SMTP id 00721157ae682-8ab3fa8a788so10142137b3.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790693915; x=1791298715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kY3drwzw6mde/wQR+dfP8Cul+pAstPntnmIstXJS9hI=;
        b=iOITVMBDzICf0QoDgjl0qcEZsNDpnFk1QY+Bl5r+wT4a+IuDvT0szmmMv2YaKFVH9N
         PqP9dRT/l4QmC5MPCTBcHyU5sSYEYOM+GIRu5Ney6Seg96A4q+9yFBrFdI4Fre1kmhJJ
         2d/g+kPKsrfmD2y8itPcqypBFBimPKYR1QXLlnNe5yBF0vMe/o3nS+UuP4Wpdy2wa5Ii
         unVHb5HfCraTrK3BBBAWfN5OkQeOLy5qLAjKO3F3QToJ0dW5KjfBNXCQfhIBXxTJ/UyE
         CoV+ycBEPqCFPoPgpKcjatgI84zOr1tUfWfbwTGqXr5oCoiD0O8ViB86RfnuVYcw6rgA
         MYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790693915; x=1791298715;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kY3drwzw6mde/wQR+dfP8Cul+pAstPntnmIstXJS9hI=;
        b=oPdcH3RujzWTc3vcYlUexoYhP6Rvn8QGISgAk0RZZHqdvXrWTZbI5yxpucJEmmUq94
         L0oko4iZSe0TVAp0KoXHpjBCq/wG3el+ZzHwO7FVwXBptEwYMyIiXuwLw3njBXjfmIpY
         X8xogkQb4Q514J1hO7HkGJKfzU92ah4b1s/gCwX4kCdmgwcKtwEy2pKmLXY2EyMD7QF0
         aWHaspr8gP4PyvZMfQ33suPb8vqNvC1u5D2lJPR3twZXh7IEmE0barhB+KsUNcNTDTgp
         hi7iGINvly6P/9x5CJOVoTY5p+ikOBlpdXAVPmJ7fkGOXaZwy8rwmDGn1MTKKktx27hO
         Mebw==
X-Forwarded-Encrypted: i=1; AKwUvBy92bC/wCiXEhqR8hOvrtLImnQacWNUcIM/xT7PbDsM6rOxBatQR5LpZoMPdf24B1HHFc2HVd8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJKN7hoEWKc2L7ll+UJOWOEzi2xCp5njkMWsbSvivFsnk4+bdq
	rjl6E9xVVpCu+3fGyPpOGQy2eqhFPtIbwZuz6iDrIbLU7MSHXeBjD8kk
X-Gm-Gg: AYBFou3t9VUWd7iIqJH06p0Fq/kI2+CET7NiG4P1J4V+SQmVYyTNZhFV/oNauGl7xVz
	DcZDqTcWyf5bIUnx75kb+Y59BTAMmDcXvv1IJV+ueD23k2YMPJ1mqZweHRGg9D87mygL7Ux+LIG
	7zYO06fDQNvjcJeHU4hS5iPSPmGdNjUgy5CSfrI8iBuuaWyK+ByWSWkOm1sXDy2ZiEoNvBJfMf7
	rCM8RIkgsmSgAUu9AVQYJdHM8O8djfDsKkvt348KouCKswNv4YRRpsRUSJbusZcPw3PY46XHDV9
	tN81bBluApr3E4drTgiqqvwQtmt8kE4UWVH2DhJeQt79H4CCEaY7CKCo8vhcpAr//VEn8GfffYK
	QxmyUhlD7b/JBHr6XnLFgjOFkl6JVgJ0nTdpTBzqTuDW7UFc5nk1E+sN0qe0f5nqY9OnZpCCybh
	wHJia3Up3aj138ayPdILd0qEm226axMXr8Z/PZ3SMXdkdfafNPkBN7N67kh0nXRtHxpoGPZbLoU
	xugQw2AYe1xSnS6u+3oJxWtBfVAtZK62D+UFOG4KU9XEMFqxCs5
X-Received: by 2002:a05:690c:9c0f:b0:8a8:4cd6:b366 with SMTP id 00721157ae682-8a84cd6b68amr53737737b3.34.1790693915243;
        Tue, 29 Sep 2026 07:58:35 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860e5a5e9sm60240577b3.17.2026.09.29.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:58:34 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:58:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Quchaosheng <quchaosheng000406@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Quchaosheng <quchaosheng000406@163.com>
Message-ID: <willemdebruijn.kernel.19517152cbe21@gmail.com>
In-Reply-To: <20260929073648.2748099-1-quchaosheng000406@163.com>
References: <willemdebruijn.kernel.2d23ff6855a34@gmail.com>
 <20260929073648.2748099-1-quchaosheng000406@163.com>
Subject: Re: [PATCH v3 net] net/packet: guard the ll header push in
 packet_rcv_spkt()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Quchaosheng wrote:
> Agreed, this is not a fix for that change.  init_can_skb() is being fixed
> separately -- zjamg's patch, now 05/22 in Marc's tree.
> 
> packet_rcv_spkt() is the only ll header restore that d549699048b4 left
> without a dev_has_header() check, and SOCK_PACKET reaches it.  That is all
> this patch is.

Perfect. Thanks for verifying.

