Received: from helium.schroedingers-bit.net (helium.schroedingers-bit.net [94.16.120.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0931327F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.120.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048520; cv=none; b=i2l1Xh8uiiZGT+/POOoh8/xKj8RpcKYml3alG+kUM4uYDX8WR2Njbi5+NMJIqHU1Lza6qCvK79hGXwxtj7mOamEPFP3fNYB9dZx7c5+5+XeX34DorJLuGXF7D7msrfz2h5g10QcsFWgICX8RIHpWvyN01oAwohSD/muCf2XZnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048520; c=relaxed/simple;
	bh=qzW6aev4COlrQUfRViYoYe4RlLx41xsUX/RO6DhKLbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5nnEkUgOzu54ir7M8OoQt2H1pss0+MuHfzaj5IvOManGAXjsYN3JWVsruQmZEfyA1hxbvGu8BDY6rVnCAMIfP3bZr+aLC0OlIUGQpeLlZHDPsqoBYUpqnnHBNHo+NDuAuKTKMhMuhXNDy/kR8ZPst8GcbwdOwHL2MndwFAjQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schroedingers-bit.net; spf=pass smtp.mailfrom=schroedingers-bit.net; arc=none smtp.client-ip=94.16.120.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schroedingers-bit.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schroedingers-bit.net
Received: from eldingar.service.vpn.picture-instruments.com (2a0a-a54a-a968-0-ea9c-25ff-fe12-908b.ipv6dyn.netcologne.de [IPv6:2a0a:a54a:a968:0:ea9c:25ff:fe12:908b])
	by helium.schroedingers-bit.net (Postfix) with ESMTPSA id 5526887044;
	Wed, 25 Feb 2026 19:41:50 +0000 (UTC)
From: Daniel Schulte <trilader@schroedingers-bit.net>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	Daniel Schulte <trilader@schroedingers-bit.net>
Subject: [PATCH netdev-next v2] ss: Remove trailing whitespace when output is not a TTY
Date: Wed, 25 Feb 2026 20:39:03 +0100
Message-ID: <20260225194104.3182640-1-trilader@schroedingers-bit.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225102331.6d09b8b9@phoenix.local>
References: <20260225102331.6d09b8b9@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes a value in the last column might be very long.
When grepping ss output the matched lines are also padded to the longest value.
In some cases this can result in multiple lines of the terminal getting filled
with spaces.

Don't print right padding in last visible column when ss can't determine the
screen width.

Signed-off-by: Daniel Schulte <trilader@schroedingers-bit.net>
---
Resubmitting as v2 using git send-email.
---
 misc/ss.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index b3566f6b..2cd6b470 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1211,7 +1211,7 @@ static int render_screen_width(void)
  * aligned across lines. Available screen space is equally spread between fields
  * as additional spacing.
  */
-static void render_calc_width(void)
+static bool render_calc_width(void)
 {
 	int screen_width, first, len = 0, linecols = 0;
 	struct column *c, *eol = columns - 1;
@@ -1245,7 +1245,7 @@ static void render_calc_width(void)
 
 	if (compact_output) {
 		/* Compact output, skip extending columns. */
-		return;
+		return compact_output;
 	}
 
 	/* Second pass: find out newlines and distribute available spacing */
@@ -1304,6 +1304,7 @@ newline:
 		len = 0;
 		linecols = 0;
 	}
+	return compact_output;
 }
 
 /* Render buffered output with spacing and delimiters, then free up buffers */
@@ -1311,7 +1312,8 @@ static void render(void)
 {
 	struct buf_token *token;
 	int printed, line_started = 0;
-	struct column *f;
+	struct column *f, *last_visible_column = 0;
+	bool compact_output = false;
 
 	if (!buffer.head)
 		return;
@@ -1321,11 +1323,18 @@ static void render(void)
 	/* Ensure end alignment of last token, it wasn't necessarily flushed */
 	buffer.tail->end += buffer.cur->len % 2;
 
-	render_calc_width();
+	compact_output = render_calc_width();
 
 	/* Rewind and replay */
 	buffer.tail = buffer.head;
 
+	f = columns;
+	while (!field_is_last(f)) {
+		if (!f->disabled)
+			last_visible_column = f;
+		f++;
+	}
+
 	f = columns;
 	while (!f->width)
 		f++;
@@ -1340,7 +1349,8 @@ static void render(void)
 		/* Print field content from token data with spacing */
 		printed += print_left_spacing(f, token->len, printed);
 		printed += fwrite(token->data, 1, token->len, stdout);
-		print_right_spacing(f, printed);
+		if (!compact_output || f != last_visible_column)
+			print_right_spacing(f, printed);
 
 		/* Go to next non-empty field, deal with end-of-line */
 		do {
-- 
2.53.0

