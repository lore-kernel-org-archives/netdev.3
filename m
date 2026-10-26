Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975330;
	b=IOkUIgz5dSv7JcwxvYWnGXOYi4TobxsNCS3O3RZLbep0JQKVuj1+Q22s4M54/puzLKBl
	 DfE24tEmhDKWAk7M6lJGbKdX14n9Fo8mzFU7qJY0v9b9mV+dowdMsHgyjko3bwK9KFFnm
	 geGfBA1yxHW8BqjUxZM/RdKEOFEz5U5+A7lEsp6nSVJ41NnYQF0kx9BiWq7G5auspWP9U
	 6AKf0jdg5+jKaY7QAmH1YB/zxYHVQOQDqroTXVoQDq2UNDl9i/pEtEJIc/dPIQcBvQStj
	 cnxAqEvtDHNF8nM7El6IF13dBH02ghd+klDS+SL6Y/Suf3R2ph+yzAvn3pJo4B0ycHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975330;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=2ahewFzKFWxBTcMVIGXl10QU/WgI3WJ8YuHN11fa1L45PqfSPBt4g9P459yPKYvKDHdU
	 HMwNj+ahzIjIaHpgl+TcgwdUE1ahCVJZx4ed+nUeXEC49dqQQyIRdTI+A9J+zJz9F+6+x
	 FjQXCku5ET21/0DZTLu6ifmREEhy4T+UJX0V7UOGOB+gToQpilBAtBdRfAP65y7L7Nr/e
	 gJQ8pHtb1YyBmRapP5PzrvYmgj7x8dQEgOkXQe4OPyhDJObpNBWNIgoVZuIwiVPdfSbWY
	 BnG3xRHdAlxD1HAljiWVHLPmNl+gOe9JvVrwVXJ3L8cOupwr11n08lzJTev6yqinMMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFRyW9ci;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2169606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFRyW9ci
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89471F01825;
	Mon, 26 Oct 2026 00:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792975329;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFRyW9ci2rdPc4cif/kIGbi14Xk8LeVPM35rO2C9Pws1RzhGeRa4Qq1xm9BJMaEuN
	 TVPwi/9R3jgAe/TJjAKSJHwQYOjrVX1b0Pt/hnmunxIrFB2nLOTgBd+jW3qgwOUO3v
	 h8fOrkVDaDMYXbICA+dBYpp1ZMh26z65CEDkayqJEIKD1POms411k1otZE5VTbo4sS
	 xkzB8hAles9xVB3JpAvpREmWg13VKfHZg8jpH7ovvfC/fr1bX7KWAZCoJCI79SFPfp
	 Uc8mwMZj+e0U72sPb3Jfx6O5/0CIt4QomNOMStaNMKlaUmvmFWqW75IaZWnBgSAQEC
	 QlAm9cSWOZsPA==
From: netdev-bot+sinfo@kernel.org
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] inet: fix lockless ehash walk races
Date: Mon, 26 Oct 2026 00:42:08 +0000
Message-ID: <179297532848.3327.7260871340859769947@kernel.org>
In-Reply-To: <20261026003804.61923-1-imv4bel@gmail.com>
References: <20261026003804.61923-1-imv4bel@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
