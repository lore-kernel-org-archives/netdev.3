Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303452D97BA;
	Sat, 26 Sep 2026 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384151; cv=none; b=gYzxrnQ7h5ZhJibcO56HJ1YQzuXJ1MJZgzcG5Uvy3/0hyYcTXXQGDE6IRjlTsh7oqYkPQ3Bi5NRnrS/nWkNK9SmrF0Vm6gdate6GginlD+1GIgsp2XPTEvGfbIviQef55KUJHinNXbf80ClJpCA9dY4sCZ6ZGGkkIRbEi8nZbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384151; c=relaxed/simple;
	bh=7fZwGNg1alr7rywDAcm52DIN3CzBYIonx0I8sloqikA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5uDYCPjA5AODAplDpAyjO7BAFr1VDAyjpZeJcftSRP3AipfzuLEDIk1RPXJrQrJnuLc741s1EUHE1l85avZMEjqUYc8NcYGwUsiQTdjo3pRblV/5sGcy/Funcpx+4/g6up+YV2BZdzyUE6ypWdSk+oDXLJcMHUocWH/QJhoh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajcJfFeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajcJfFeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F9C1F000FF;
	Sat, 26 Sep 2026 00:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384149;
	bh=+GwjeJGTOQqRLr9cEJqI15yVfK9bVUSfsx1ej80BZho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ajcJfFeEUt7lTRlt/lCgzsVoz1k9m7dEWYkEPSTF/sYWmXxVxlrPUffzZwJPldfj+
	 2Jczm8u5rwjWNcDvtzabkbhr0IO84AF+me5v7b2f6Nlac1eihevCk4DLY8c1XqP558
	 /AjXmJn6D1s2wZlpmMvQodXSrJ+GC/CpV8tcQC30Qstbj96M8Gjb9/nInI9p8S8pnr
	 hUgn6h7OX2e8qdGwk1hS/SJL4Bd0KmRiNBMZslG8V30qAoXZbXYHhnIODM9JtdFcZt
	 hk81WDpkd1oxvQ6a4LJlur+joAiIqB+1++6C4uxVhuxTaD9YB/HCc2mm1vO/cdDwlx
	 x2/apOOXMS8ZQ==
Date: Fri, 25 Sep 2026 17:55:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: chrismelnu@gmail.com, florian.fainelli@broadcom.com,
 jonas.gorski@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: dsa: b53: fix stale tagging-support
 section
Message-ID: <20260925175548.2917d0d0@kernel.org>
In-Reply-To: <179019827202.2160803.3779708917982788607@kernel.org>
References: <20260922211439.369917-1-chrismelnu@gmail.com>
	<179019827202.2160803.3779708917982788607@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Sep 2026 21:17:52 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] The patch deletes the whole "Configuration without tagging
>   support" section of Documentation/networking/dsa/b53.rst, including=E2=
=80=A6

Could someone who knows this HW confirm / refute the AI report?
