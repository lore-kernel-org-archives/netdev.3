Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE28392C56;
	Tue, 18 Aug 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070223; cv=none; b=q9//GsHVkFX6LFxI26wdaqq50jptyhb5+CxKCuWp0TX4IO5YIw+FVVhDHoJTAWW/jNVt6xzx4nXIKa8ZfumwyWkJtaGGeQPFfXxWloiEs+HhNEeZaplWk0s1uNXIK/LxMZReqnBVrdzVJSo//eFiGzvPfYgj2bp3bGtVOpJ+xnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070223; c=relaxed/simple;
	bh=jv0VXZ7QnQet0wFM0ajlWqDM1CV84AOtASaA2yi1sgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6t/Su6Bu/ZAWqgy95lQUidcFN2JRRy7BKv1MM0WvAcXuTCUZuE48zkopxtJNqChBE9IuCazzM4BlhiHJj+mN7WwKz+6WzYjXmEYs7VFmBl69JbfjcEpqbx9ecK3PXnuouSvGkMFI+Snpl6fZ0GeQBmtexFoMfetmUIWnTNU2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut6T5Bkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut6T5Bkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A042D1F000E9;
	Tue, 18 Aug 2026 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787070222;
	bh=t9nNMivFtc40xgKfsW62IE93eNKdK7x9iMT1ojg7RSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ut6T5BkzXDAa/lBjhGWskE08U6y2K22QV/th96/s4VCN1TdlQM88EJyzNinZyKkpz
	 gfJMimOw6PIlKGZ5tvj64Xey+qD+TIaJPtbvw3tTfhTUaLuRYCtuPcWguoDrcifLzQ
	 RLREWsEm2Bixpcv3DWgNIc/Eq93Ia3O0iovKNJdRpZ3LpnYErQzW2ZZPOlr8iBfgMt
	 EnbkvYfq+Gf7X9KGnMI7tZZiZPwyJpQZleKd+gvL0vPwhBTZr486mAg7R3xaxXOCXO
	 6lZqa/vb9PNohAq2+3cu0mLoNce0PTFpCG8H9OGHuYtVjGkG18kJ7Q7tZgEjeYs96b
	 U3xD4AFbm0XpQ==
Date: Tue, 18 Aug 2026 09:23:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_subashab@quicinc.com, quic_stranche@quicinc.com, doruk@0sec.ai
Subject: Re: [PATCH net] net: qualcomm: rmnet: require CAP_NET_ADMIN in the
 real device netns for changelink
Message-ID: <20260818092340.080cbdec@kernel.org>
In-Reply-To: <20260813174727.14857-1-suruurism@gmail.com>
References: <20260813174727.14857-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 20:47:27 +0300 Abdifatah Suruur wrote:
> Reported-by: Abdifatah Suruur <suruurism@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

If you are the author the Reported-by is implied.
please fix this and repost.
-- 
pw-bot: cr
