Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A704503FA;
	Mon, 21 Sep 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023514; cv=none; b=no/tMrdfv0744qNxWT2ZMEHCuOH+0otyB5MJzgxpHOg4bTis1zdQmRP3ZxNj0S2yJugJqh0VFPR4dNjPw0CnhP7MAEeZXzcmS9c27w+puJcd58Y0jioYM4989GaHSHrIovrSbfukWAf+rZ2kiKt3blyho7Ryv9vMtw69EfZbpFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023514; c=relaxed/simple;
	bh=kcF22VUobwWbWa99LPEfKyuJigNoHUtasPa2CQMxCKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuuuYfDDauRo8S6m/M/bG9yP+qFjux4NI61Re68mSRArYWKai5U46wosrgKfnkq+DKFcAVvfl1ltmZBTTKqR+jH9fFiQZNmFJpmMekLrACkw0DEbHEri6rvxCPAnWj+cdsHHlyorAIuUVAhTLZnxLY+/jtB1l24nQg/1HF16EGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FADylYuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FADylYuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CA01F000FF;
	Mon, 21 Sep 2026 20:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023512;
	bh=Fzt5Cc+pEHYrAurg2fhFO3ZsZafIssnJqcvEORr7eHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FADylYuGgh7eTbHl2lsirnCrSPAaRyeapLq+VKA3C/8ej6wvmOLHprWEt4Y9h/a3n
	 VO0Reyr11Wx6Vwo9FEHwWslsQkFP40i7aKP/wBJUtpykPF1pvUd2QWqgm9iPTZ3opL
	 NuIiJXRMaKKOAAQlL1ENMS9meRz2B1K081pmjaJYMH+HnJ219sA+fVq78Nv7RlPHNK
	 rhjptzw/B8ygLSZnUmvYCgrcJGiJpc0xO7warDly3WasgvwpFkaFzRLOD4vpmcbaUY
	 K1cVfrBF3NC06ku2CuOJqwPXGVdMcJiwpJaHtu8q6DTpDQ1xeW66aVoV2Fr1uq1ayx
	 Eac3V/xrwsxrg==
Date: Mon, 21 Sep 2026 13:45:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: <netdev-bot+sashiko@kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] ch9200: do return USB errors from
 control_write()
Message-ID: <20260921134511.4f61f79d@kernel.org>
In-Reply-To: <354d72f6-35bc-49f0-a4f4-3555b03f0ad8@auroraos.dev>
References: <20260915185805.38712-1-s.shtylyov@auroraos.dev>
	<178954341078.22033.8722936070498955076@kernel.org>
	<b43350d5-09d7-4fc4-9791-16bb4322d794@auroraos.dev>
	<20260918182124.487edd13@kernel.org>
	<354d72f6-35bc-49f0-a4f4-3555b03f0ad8@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 22:59:10 +0300 Sergey Shtylyov wrote:
> >>    That's what the patch I linked to does...  
> > 
> > Please fix the issues in one series or not at all.  
> 
>    OK. Series against net-next, right?

yes
